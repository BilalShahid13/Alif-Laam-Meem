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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Test"
        Setup()
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! TestBoardCVCell
        cell.TestBoardButton.setTitle("Word", for: .normal)
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
                let sbPopup = SBCardPopupViewController(contentViewController: popUp)
                sbPopup.show(onViewController: self)
            } else {
                print("couldn't find index path")
            }
        }
    }
}
