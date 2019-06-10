//
//  StudentAssessmentItemsVC.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 06/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class StudentAssessmentItemsVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,AppliedRulesVCDelegate{
    
    func sendAssessmentsback(studentAssessmentitems: [Test]) {
        self.studentAssessmentitems = studentAssessmentitems
    }
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var student: Student?
    var assessment: Assessment?
    var studentAssessmentitems: [Test]?
    var iDetail = [itemDetails]()
    var tempIDetails = itemDetails(itemId: "",submitted: false,itemType: 0)
    lazy var refreshTestBoard = UIRefreshControl()
    let reuseIdentifier = "assessmentItem"
    let impact = UIImpactFeedbackGenerator()

    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(3)
    var itemHeight = CGFloat(10)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Assessment Items"
//        refreshTestBoard.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshTestBoard.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
//        CollectionView.addSubview(refreshTestBoard)
        Setup()
        requestData()
    }
    @objc func refresh(sender:AnyObject) {
        self.checkAllSubmissions()
        self.refreshTestBoard.endRefreshing()
    }
    func requestData(){
        activityIndicator.startAnimating()
        let jsonUrlString = TaskManager.serverIP + "TestService/TestData"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let reqTest = requestTest(lessonId: assessment?.lessonId ?? 0,studentId: student?.studentId ?? 0)
        do {
            let loginBody = try JSONEncoder().encode(reqTest)
            urlRequest.httpBody = loginBody
        } catch  {}
        TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            do{
                let resp = try JSONDecoder().decode([Test].self, from: data)
                self.studentAssessmentitems = resp
                self.CollectionView.reloadData()
                self.checkAllSubmissions()
                self.iDetail.removeAll()
                self.activityIndicator.stopAnimating()

            }catch let error{
                print("Error decoding",error)
                self.activityIndicator.stopAnimating()

            }
        }
    }
    func Setup(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing=10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        CollectionView!.collectionViewLayout = layout
        CollectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let wordBlocks = (studentAssessmentitems?.count ?? 0) - 1
        return ((section == 1) ? wordBlocks : studentAssessmentitems?[0].items.count) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkSubmission(indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! StudentAssessmentItemsCVC
        if(indexPath.section == 0){
            cell.itemValue.text = studentAssessmentitems?[0].items[indexPath.row].itemValue
        }else{
            cell.itemValue.text = studentAssessmentitems?[indexPath.row + 1].word_value
        }
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func checkAllSubmissions(){
        let jsonUrlString = TaskManager.serverIP + "TestService/checkItemsSubmission"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //Checking Submission of items
        for index in 0..<studentAssessmentitems![0].items.count{
            tempIDetails.itemId = String(studentAssessmentitems![0].items[index].itemId)
            tempIDetails.submitted = false
            tempIDetails.itemType = 0
            iDetail.append(tempIDetails)
        }
        for index in 1..<studentAssessmentitems!.count{
            tempIDetails.itemId = String(studentAssessmentitems![index].word_id)
            tempIDetails.submitted = false
            tempIDetails.itemType = 1
            iDetail.append(tempIDetails)
        }
        let checkSub = checkItemsSubmission(studentId: String(student!.studentId),lessonId: String(assessment!.lessonId),itemsDetail: iDetail)
        do {
            let requestBody = try JSONEncoder().encode(checkSub)
            urlRequest.httpBody = requestBody
        } catch  {}
        TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            do{
                let resp = try JSONDecoder().decode(checkItemsSubmission.self, from: data)
                print(resp)
                let itemsCount  = resp.itemsDetail.count
                for index in 0..<itemsCount{
                    if resp.itemsDetail[index].itemType == 0 && !resp.itemsDetail[index].submitted{
                        for secondIndex in 0..<self.studentAssessmentitems![0].items.count{
                            let indexPath = IndexPath(row: secondIndex, section: 0)
                            let cell = self.CollectionView.cellForItem(at: indexPath) as! StudentAssessmentItemsCVC
                            if resp.itemsDetail[index].itemId == String(self.studentAssessmentitems![0].items[secondIndex].itemId){
                                cell.itemValue.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                                cell.itemValue.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                            }
                        }
                    }
                    else if resp.itemsDetail[index].itemType == 1 && !resp.itemsDetail[index].submitted{
                        for secondIndex in 1..<self.studentAssessmentitems!.count{
                            let indexPath = IndexPath(row: secondIndex - 1, section: 1)
                            let cell = self.CollectionView.cellForItem(at: indexPath) as! StudentAssessmentItemsCVC
                            if resp.itemsDetail[index].itemId == String(self.studentAssessmentitems![secondIndex].word_id){
                                cell.itemValue.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                                cell.itemValue.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                            }
                        }
                    }
                }
            }catch let error{
                print("Error decoding",error)
            }
        }
        iDetail.removeAll()
    }
    func checkSubmission(indexPath: IndexPath){
        let jsonUrlString = TaskManager.serverIP + "TestService/checkItemSubmission"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Checking Submission of item
        var checkSub = checkItemSubmission(studentId: "1",lessonId: "0", itemDetail: tempIDetails)
        if indexPath.section == 0{
            tempIDetails.itemId = String(studentAssessmentitems![0].items[indexPath.row].itemId)
            tempIDetails.submitted = false
            checkSub = checkItemSubmission(studentId: String(student!.studentId),lessonId: String(assessment!.lessonId), itemDetail: tempIDetails)
        }else{
            tempIDetails.itemId = String(studentAssessmentitems![indexPath.row + 1].word_id)
            tempIDetails.submitted = false
            checkSub = checkItemSubmission(studentId: String(student!.studentId),lessonId: String(assessment!.lessonId), itemDetail: tempIDetails)
        }
        do {
            let requestBody = try JSONEncoder().encode(checkSub)
            urlRequest.httpBody = requestBody
        } catch  {}
        TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            do{
                let resp = try JSONDecoder().decode(checkItemSubmission.self, from: data)
                print(resp)
                if !resp.itemDetail.submitted{
                    let alert = UIAlertController(title: "Alert", message: "Not submitted", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "appliedRulesPopup") as! AppliedRulesVC
                    destinationVC.delegate = self
                        if indexPath.section == 0{
                            destinationVC.itemType = 0
                            destinationVC.itemIndex = indexPath.row
                        }else{
                            destinationVC.itemType = 1
                            destinationVC.itemIndex = indexPath.row + 1
                        }
                        destinationVC.studentAssessmentitems = self.studentAssessmentitems
                        destinationVC.studentId = self.student?.studentId
                        destinationVC.lessonId = self.assessment?.lessonId
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
            }catch let error{
                print("Error decoding",error)
            }
        }
    }
}
