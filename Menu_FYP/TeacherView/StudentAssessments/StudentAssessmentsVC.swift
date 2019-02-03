//
//  StudentAssessmentsVC.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 06/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class StudentAssessmentsVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var student: Student?
    var assessment: Assessment?
    var studentAssessmentitems: Test?
    let reuseIdentifier = "assessmentItem"
    
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(3)
    var itemHeight = CGFloat(10)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Assessment Items"
        setup()
        requestData()
    }
    func requestData(){
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
                let resp = try JSONDecoder().decode(Test.self, from: data)
                self.studentAssessmentitems = resp
                self.CollectionView.reloadData()
            }catch let error{
                print("Error decoding",error)
            }
        }
    }
    func setup() {
        
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
        return studentAssessmentitems?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! StudentAssessmentCVC
        cell.itemValue.text = studentAssessmentitems?.items[indexPath.row].itemValue
        return cell
    }
}
