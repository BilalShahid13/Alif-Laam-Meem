//
//  StudentAssessmentLessonsViewController.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 21/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class StudentAssessmentLessonsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var studentName: UITextView!
    @IBOutlet weak var regNumber: UITextView!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var studentImage: UIImageView!
    var student: Student?
    var listAssessments: TheirAssesments?
    let reuseIdentifier = "TeacherAssessmentCell"
    
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(3)
    var itemHeight = CGFloat(10)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestAssessments()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func requestAssessments(){
        self.activityIndicator.startAnimating()
        let jsonUrlString = TaskManager.serverIP + "TeacherService/getSubmittedLessons"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let rI = requestItem(id: student?.studentId ?? 0)
        do {
            let loginBody = try JSONEncoder().encode(rI)
            urlRequest.httpBody = loginBody
        } catch  {}
        TaskManager.shared.dataTask(withRequest: urlRequest){ (data, response, error) in
            guard let data = data else {return}
            do {
                let resp = try JSONDecoder().decode(TheirAssesments.self, from: data)
                print(resp)
                self.listAssessments = resp
                self.CollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            } catch let error{
                print("Error decoding",error)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    func setup() {
        studentName.text = student?.fullName
        regNumber.text = "09090"
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        itemWidth =  self.view.frame.width
        itemHeight = self.CollectionView.bounds.height
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: 55)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = 3
        layout.scrollDirection = .vertical
        CollectionView!.collectionViewLayout = layout
        CollectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAssessments?.assessments.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! StudentAssessmentLessonsCollectionViewCell
        cell.assessmentCell.setTitle(listAssessments?.assessments[indexPath.row].lessonTitle, for: .normal)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "assessmentItems") as! StudentAssessmentItemsVC
        destinationVC.student = student
        destinationVC.assessment = listAssessments?.assessments[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
