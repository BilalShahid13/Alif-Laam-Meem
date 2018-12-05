//
//  GridViewController.swift
//  Menu_FYP
//
//  Created by Amir Mughal on 11/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit
import AVFoundation
class GridViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var GridCollection: UICollectionView!
    let reuseIdentifier="GridButton"
    var gridType:String=""
    var subLessonIndex:Int = -1
    var activityIndex:Int = -1
    var QaidaData = Qaida()
    var words = [String]()
    var newWords = [String]()
    var soundPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        QaidaData = getQaidaData()
        words=QaidaData.getwords(index: activityIndex)
        setup()
    }
    func setup() {
        if(gridType == "subLesson"){
            if(subLessonIndex != -1){
                self.title = "Sub Lesson " + String(subLessonIndex)
                let wordsSize:Int = words.count/3
                print(words.count/3)
                if(subLessonIndex != 3){
                    for i in (wordsSize*(subLessonIndex-1))..<(subLessonIndex*wordsSize){
                        print(i,words[i])
                        newWords.append(words[i])
                    }
                }
                else{
                    for i in (wordsSize*(subLessonIndex-1))..<(words.count){
                        print(i,words[i])
                        newWords.append(words[i])
                    }
                }
            }
        }
        else if(gridType == "practice"){
            newWords=words
            self.title = "Practice"
        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing=10
        layout.scrollDirection = .vertical
        GridCollection!.collectionViewLayout = layout
        GridCollection?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(gridType == "subLesson"){
            if(subLessonIndex == 3){
                return words.count - ((words.count/3)*(subLessonIndex-1))
            }
            else{
                return words.count/3
            }
        } else{
            return words.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! GridViewCell
    
        cell.GridButton.setTitle(newWords[indexPath.row], for: .normal)
        cell.GridButton.titleLabel?.font = UIFont(name: "maddina.ttf", size: 24)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var index: Int = 0
        var soundFileFormat: String = ""
        
        if(gridType == "subLesson"){
            index = (words.count/3)*(subLessonIndex-1) + indexPath.row
            soundFileFormat = String(activityIndex+1) + "_" + String(index)
        }
        else if(gridType == "practice"){
            index = indexPath.row
            soundFileFormat = String(activityIndex+1) + "_" + String(index)
        }
        print(soundFileFormat)
        let subDirect:String = "QaidaData/Audio/Takhti_" + String(activityIndex)
        guard let url = Bundle.main.url(forResource: soundFileFormat, withExtension: "mp3",subdirectory: subDirect) else { return }
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = soundPlayer else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/6, height: collectionViewSize/5)
    }
}

