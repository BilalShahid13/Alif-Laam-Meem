//
//  TeacherClassStudentsViewController.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 02/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class QuranSurahsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    var rowIndex = 0
    let reuseIdentifier = "SurahCell"
    var quranData = quran()
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(3)
    var itemHeight = CGFloat(10)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    var teacher: User?
    var listStudents: MyStudents?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Quran"
        setup()
        // Do any additional setup after loading the view, typically from a nib.
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
        return 113
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! QuranSurahsCollectionViewCell
        cell.surahName.text = quranData.surahName[indexPath.row]
        cell.surahPage.text = quranData.surahPage[indexPath.row]
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "studentAssessments") as! StudentAssessmentLessonsViewController
        destinationVC.student = listStudents?.students[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
