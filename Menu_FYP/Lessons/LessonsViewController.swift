//
//  LessonsViewController.swift
//  Menu_FYP
//
//  Created by Amir Mughal on 11/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class LessonsViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let reuseIdentifier = "LessonsCell"
    @IBOutlet weak var Theory: UIButton!
    @IBOutlet weak var Sublessons: UICollectionView!
    @IBOutlet weak var Practice: UIButton!
    @IBOutlet weak var Test: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    func setup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        Sublessons!.collectionViewLayout = layout
        Sublessons?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! lessonsCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize, height: collectionViewSize/2)
    }
}
