//
//  QuranCollectionViewController.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 2/12/19.
//  Copyright © 2019 Bilal Shahid. All rights reserved.
//

import UIKit

private let reuseIdentifier = "QuranCell"

class QuranCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let itemSpacing = CGFloat(1)
    var itemWidth = CGFloat(0)
    var itemHeight = CGFloat(0)
    var currentItem = 0
    var indexScroll = 0
    public var surahName = [String]()
    public var surahPageNumber = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationTitleFont = UIFont(name: "KFGQPCUthmanicScriptHAFS", size: 28)!
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont]
        collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        collectionView.center = self.view.center
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 604
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! QuranCollectionViewCell
        
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        cell.pageLabel.text = String(indexPath.row + 1)
        let fileName = "page" + String(format: "%03d", (indexPath.row+1))
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: "png")
            else {
                print("File Read Error for file")
                return cell
        }
        let imageUrl: URL = URL(fileURLWithPath: filepath)
        do {
            let imageData: Data = try Data(contentsOf: imageUrl)
            if let image: UIImage = UIImage(data: imageData){
                cell.pageText.image = image
            }
            else{
                return cell
            }
        } catch {
            print("File Read Error for file \(filepath)")
        }
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if indexScroll != 0 {
            let indexPath = IndexPath(item: indexScroll, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: false)
            indexScroll = 0
        }
        
        // Set Correct Surah as Title (Fixed)
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        if visibleIndexPath != nil{
            if surahPageNumber.contains(String(visibleIndexPath!.row + 1)){
                if visibleIndexPath!.row < 604 {
                    self.title = surahName[surahPageNumber.firstIndex(of: String(visibleIndexPath!.row + 1))!]
                }
            }
            else if surahPageNumber.contains(String(visibleIndexPath!.row + 2)){
                if visibleIndexPath!.row < 604, visibleIndexPath!.row > 1 {
                    self.title = surahName[surahPageNumber.firstIndex(of: String(visibleIndexPath!.row + 2))! - 1]
                }
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
}
