//
//  TeacherClassStudentsViewController.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 02/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class QuranSurahsTableViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 114
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "surahCell") as! QuranSurahsTableViewCell
                cell.surahName.text = quranData.surahName[indexPath.row]
                cell.surahPage.text = quranData.surahPage[indexPath.row]
                return cell
    }

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
        self.title =  "Surahs"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9242517352, green: 0.9300937653, blue: 0.9034610391, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo",size: 21)!]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "quranText") as! QuranCollectionViewController
        destinationVC.indexScroll = Int(quranData.surahPage[indexPath.row])! - 1
                print (indexPath.row)        
        destinationVC.surahName = quranData.surahName;
        
        destinationVC.surahPageNumber = quranData.surahPage; self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
