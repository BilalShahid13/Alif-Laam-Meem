//
//  TeacherClassStudentsViewController.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 02/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class MyStudentsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var className = "Tajweed Class"
    var rowIndex = 0
    
    let studentNames = ["Bilal Shahid", "Fahd Rizvi", "Amir Shakoor"]
    let rollNum = ["i150074", "i150061", "i150272"]
    let reuseIdentifier = "StudentNameCell"
    
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(3)
    var itemHeight = CGFloat(10)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    var teacher: User?
    var listStudents: MyStudents?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Students"
        setup()
        requestStudents()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func requestStudents(){
        self.activityIndicator.startAnimating()
        let jsonUrlString = TaskManager.serverIP + "TeacherService/getStudents"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let rI = requestItem(id: teacher?.id ?? 0)
        do {
            let loginBody = try JSONEncoder().encode(rI)
            urlRequest.httpBody = loginBody
        } catch  {}
        TaskManager.shared.dataTask(withRequest: urlRequest){ (data, response, error) in
            guard let data = data else {return}
            do {
                let resp = try JSONDecoder().decode(MyStudents.self, from: data)
                print(resp)
                self.listStudents = resp
                self.CollectionView.reloadData()
                self.activityIndicator.stopAnimating()

            } catch let error{
                print("Error decoding",error)
                self.activityIndicator.stopAnimating()

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
        return listStudents?.students.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! MyStudentsCollectionViewCell
        
        cell.studentName.text = listStudents?.students[indexPath.row].fullName
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "studentAssessments") as! StudentAssessmentLessonsViewController
        destinationVC.student = listStudents?.students[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
   
}
