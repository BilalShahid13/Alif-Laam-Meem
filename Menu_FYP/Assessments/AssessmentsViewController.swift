//
//  ViewController.swift
//  Menu_FYP
//
//  Created by Bilal Shahid on 11/7/18.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var top: UILabel!
    
    
    let surahName = ["Quaida", "Quran", "Assessments"]
    let reuseIdentifier = "AssessmentCell"
    
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(3)
    var itemHeight = CGFloat(10)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    
    func setup() {
        
        top.layer.cornerRadius = 10.0
        top.layer.masksToBounds = true
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(CollectionView!.contentSize.width  )
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = surahName.count
        return surahName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! AssessmentCollectionViewCell
        
        

        cell.textView.font = UIFont(name: "KFGQPC Uthmanic Script HAFS", size: 28)
        return cell
    }
    
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

