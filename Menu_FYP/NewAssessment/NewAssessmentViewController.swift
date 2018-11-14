//
//  NewAssessmentViewController.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 14/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class NewAssessmentViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var assessmentContentCV: UICollectionView!
    let reuseIdentifier="wordButton"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing=10
        assessmentContentCV!.collectionViewLayout = layout
        assessmentContentCV?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! NewAssessmentCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/6, height: collectionViewSize/2)
    }
}
