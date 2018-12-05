//
//  QuranViewController.swift
//  Menu_FYP
//
//  Created by Bilal Shahid on 11/8/18.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

import UIKit
import AVFoundation

class QuranViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    let QreuseIdentifier = "QuranCell"
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(1)

    var itemHeight = CGFloat(322)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    
    var csvRows=[[String]]()
    var surahName=[String]()
    var surahText=[String]()
    var audioPlayer : AVAudioPlayer!
    var selectedAyahFileName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quran"
        readQuran()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        itemWidth =  self.view.frame.width
        itemHeight = self.collectionView.bounds.height
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = surahName.count
        return surahName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QreuseIdentifier,
                                                      for: indexPath) as! QuranCollectionViewCell
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        cell.titleLabel.text = surahName[indexPath.row]
        cell.textView.text = surahText[indexPath.row]
        cell.textView.font = UIFont(name: "KFGQPC Uthmanic Script HAFS", size: 28)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
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
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = contents.replacingOccurrences(of: "\"", with: "")
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    func readQuran(){
        let data=readDataFromCSV(fileName: "Quran", fileType: "csv")
        csvRows = csv(data: data!)
        let surahData=readDataFromCSV(fileName: "surahNames", fileType: "csv")
        let surahRows = csv(data: surahData!)
        var row:Int=1
        var index:Int=0
        var suraText:String=""
        var surahIndex:Int=1
        while row<csvRows.count-1{
            if(index==0){
                suraText=csvRows[row][3]
                row=row+1
                index+=1
            }
            else if(csvRows[row][2] == "1"){
                surahName.append(surahRows[surahIndex][2])
                surahText.append(suraText)
                
                suraText=csvRows[row][3]
                row=row+1
                surahIndex=surahIndex+1
            }
            else{
                suraText += csvRows[row][3]
                row=row+1
            }
        }
        surahName.append(surahRows[surahIndex][2])
        surahText.append(suraText)
    }
}
