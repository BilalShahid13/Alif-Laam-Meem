//
//  TestBoardVC.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 27/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class TestBoardVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout , UIGestureRecognizerDelegate{
    
    var activityIndex:Int = -1
    let reuseIdentifier="TestBoardCell"
    @IBOutlet weak var testBoard: UICollectionView!
    var lectureTest: Test?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Test"
        requestData()
        Setup()
        
        // Do any additional setup after loading the view.
    }
    func requestData(){
        let jsonUrlString = TaskManager.serverIP + "TestService/TestData"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let reqTest = requestTest(lessonId: 1,studentId: 1)
        do {
            let loginBody = try JSONEncoder().encode(reqTest)
            urlRequest.httpBody = loginBody
        } catch  {}
        TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            do{
                let resp = try JSONDecoder().decode(Test.self, from: data)
                self.lectureTest = resp
                self.testBoard.reloadData()
            }catch let error{
                print("Error decoding",error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lectureTest?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! TestBoardCVCell
        cell.TestBoardButton.setTitle(lectureTest?.items[indexPath.row].itemValue, for: .normal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popUp = storyboard?.instantiateViewController(withIdentifier: "newAssessmentPopup") as! NewAssessmentViewController
        let sbPopup = SBCardPopupViewController(contentViewController: popUp)
        sbPopup.show(onViewController: self)
    }
    func Setup(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing=10
        layout.scrollDirection = .vertical
        testBoard!.collectionViewLayout = layout
        testBoard?.decelerationRate = UIScrollView.DecelerationRate.fast
        
        let lpgr = UILongPressGestureRecognizer(target: self, action:#selector(checkRuleViolations))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.testBoard.addGestureRecognizer(lpgr)
    }
    @objc func checkRuleViolations(gesture : UILongPressGestureRecognizer!) {
        if(gesture.state == .began){
            let p = gesture.location(in: self.testBoard)
            if let indexPath = self.testBoard.indexPathForItem(at: p) {
                // get the cell at indexPath (the one you long pressed)
                _ = self.testBoard.cellForItem(at: indexPath)
                // do stuff with the cell
                let popUp = storyboard?.instantiateViewController(withIdentifier: "violatedRulesPopup") as! violatedRulesVC
                popUp.rules = lectureTest?.items[indexPath.row].rules
                let sbPopup = SBCardPopupViewController(contentViewController: popUp)
                sbPopup.show(onViewController: self)
            } else {
                print("couldn't find index path")
            }
        }
    }
}
