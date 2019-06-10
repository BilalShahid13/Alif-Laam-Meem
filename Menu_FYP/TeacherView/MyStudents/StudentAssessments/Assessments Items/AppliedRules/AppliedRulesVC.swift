//
//  AppliedRulesVC.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 07/02/2019.
//  Copyright © 2019 Amir Mughal. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class sendResponse:Decodable{
    var response:String
}
class AppliedRulesVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var delegate: AppliedRulesVCDelegate?
    var player: AVAudioPlayer?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var playAssessment: UIImageView!
    @IBOutlet weak var wordName: UILabel!
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var appliedRulesTable: UITableView!
    @IBOutlet weak var ok: UIButton!
    let reuseableIdentifier = "appliedRuleCell"
    let reuseableIdentifierLetter = "appliedRuleLetterCell"
    var studentAssessmentitems: [Test]?
    var screenHeight = CGFloat()
    var studentId: Int?
    var lessonId: Int?
    var itemIndex:Int?
    var itemType: Int?
    let impact = UIImpactFeedbackGenerator()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feedback"
        self.appliedRulesTable.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9294117647, blue: 0.9019607843, alpha: 1)
        screenHeight = self.view.frame.origin.y
        ok.layer.cornerRadius = 15
        ok.layer.borderWidth = 1
        ok.layer.borderColor = UIColor.black.cgColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(playButtonTapped(tapGestureRecognizer:)))
        playAssessment.isUserInteractionEnabled = true
        playAssessment.addGestureRecognizer(tapGestureRecognizer)

//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))

       // view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        if itemType == 0 {
            wordName.text = studentAssessmentitems?[0].items[itemIndex!].itemValue
            if let comment = studentAssessmentitems?[0].items[itemIndex!].rules[0].comments{
                comments.text = comment
            }else{
                comments.text = "No comments"
            }
        }else{
            //hard coded
            wordName.text = studentAssessmentitems![1].word_value
            if let comment = studentAssessmentitems![1].items[0].rules[0].comments{
                comments.text = comment
            }else{
                comments.text = "No comments"
            }
        }
        wordName.layer.cornerRadius = 15
        wordName.layer.borderWidth = 1
        wordName.layer.borderColor = UIColor.black.cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 10
           // }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {

                self.view.frame.origin.y = screenHeight + self.navigationController!.navigationBar.frame.size.height +
                UIApplication.shared.statusBarFrame.height
                
            }
        }
    }
    @objc func refresh(sender:AnyObject) {
        
    }
    func deleteExistingAudioFiles(){
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            for fileURL in fileURLs {
                if fileURL.pathExtension == "m4a" {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }
    @objc func playButtonTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        impact.impactOccurred()
        activityIndicator.startAnimating()
        deleteExistingAudioFiles()
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        //Path for File at server
        var filePath = "1_0_1"
        if itemType == 0 {
            filePath = String(studentId!) + "_" + String(lessonId!) + "_" + String(studentAssessmentitems![0].items[itemIndex!].itemId)
        }else{
            filePath = String(studentId!) + "_" + String(lessonId!) + "_" + String(studentAssessmentitems![itemIndex!].word_id)
        }
        Alamofire.download(
            TaskManager.serverIP + "TestService/downloadFile/" + filePath,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil,
            to: destination).downloadProgress(closure: { (progress) in
                //progress closure
            }).response(completionHandler: { (DefaultDownloadResponse) in
                //here you able to access the DefaultDownloadResponse
                //result closure
                let url=DefaultDownloadResponse.destinationURL!
                if(FileManager.default.fileExists(atPath: url.path)) {
                    print("File exists",url.path)
                    do {
                        self.player = try AVAudioPlayer(contentsOf: url)
                        guard let player = self.player else { return }
                        player.volume = 3
                        player.prepareToPlay()
                        self.activityIndicator.stopAnimating()
                        player.play()
                    } catch let error {
                        print(error.localizedDescription)
                    }

                } else {
                    print("file not found")
                }
            })
    }
    override func dismissKeyboard() {
        view.endEditing(true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemType == 0 {
            return self.studentAssessmentitems?[0].items[itemIndex!].rules.count ?? 0
        }else{
            return self.studentAssessmentitems![itemIndex!].items.count
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Rules"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if itemType == 0{
            let cell = appliedRulesTable.dequeueReusableCell(withIdentifier: reuseableIdentifier, for: indexPath) as! AppliedRulesCell
            cell.articulationPoint?.text = studentAssessmentitems?[0].items[itemIndex!].rules[indexPath.row].articulationPoint
            cell.characteristic?.text = studentAssessmentitems?[0].items[itemIndex!].rules[indexPath.row].characteristic
            if studentAssessmentitems?[0].items[itemIndex!].rules[indexPath.row].correct != 1{
                cell.checkBox.image = UIImage(named: "checkbox_empty")
            }else{
                cell.checkBox.image = UIImage(named: "checkbox_tick")
            }
            return cell
        }
        else{
            let cell = appliedRulesTable.dequeueReusableCell(withIdentifier: reuseableIdentifierLetter, for: indexPath) as! AppliedRulesLetterCell
            cell.articulationPoint.text = self.studentAssessmentitems![itemIndex!].items[indexPath.row].rules[0].articulationPoint
            cell.characteristic.text = self.studentAssessmentitems![itemIndex!].items[indexPath.row].rules[0].characteristic
            cell.letter.text = self.studentAssessmentitems![itemIndex!].items[indexPath.row].itemValue
            if studentAssessmentitems![itemIndex!].items[indexPath.row].rules[0].correct != 1{
                cell.checkBox.image = UIImage(named: "checkbox_empty")
            }else{
                cell.checkBox.image = UIImage(named: "checkbox_tick")

            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemType == 0{
            let selectedRow = appliedRulesTable.cellForRow(at: indexPath) as! AppliedRulesCell
                if selectedRow.checkBox.image == UIImage(named: "checkbox_empty") {
                    //selectedRow.accessoryType = .checkmark
                   selectedRow.checkBox.image = UIImage(named: "checkbox_tick")
                    studentAssessmentitems?[0].items[itemIndex!].rules[indexPath.row].correct = 1
                    
                }else {
                    //selectedRow.accessoryType = .none
                   selectedRow.checkBox.image = UIImage(named: "checkbox_empty")
                    studentAssessmentitems?[0].items[itemIndex!].rules[indexPath.row].correct = 0
                }
        }else{
            let selectedRow = appliedRulesTable.cellForRow(at: indexPath) as! AppliedRulesLetterCell
            if selectedRow.checkBox.image == UIImage(named: "checkbox_empty") {
                //selectedRow.accessoryType = .checkmark
                selectedRow.checkBox.image = UIImage(named: "checkbox_tick")
                studentAssessmentitems?[itemIndex!].items[indexPath.row].rules[0].correct = 1
            }
            else {
                //selectedRow.accessoryType = .none
                selectedRow.checkBox.image = UIImage(named: "checkbox_empty")
                studentAssessmentitems?[itemIndex!].items[indexPath.row].rules[0].correct = 0
                }
            }
    }
    func submitWordFeedback(){
        activityIndicator.startAnimating()
        let jsonUrlString = TaskManager.serverIP + "TeacherService/submitWordFeedback"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var letters = [FeedbackLetters]()
        for index in 0..<studentAssessmentitems![itemIndex!].items.count{
            var rules = [FeedbackRules]()
            var rule = FeedbackRules(ruleId: -1,correct: -1)
            if studentAssessmentitems![itemIndex!].items[index].rules[0].correct != 1{
                rule.correct = 0
            }else{
                rule.correct = 1
            }
            rule.ruleId = studentAssessmentitems![itemIndex!].items[index].rules[0].ruleId
            rules.append(rule)
            letters.append(FeedbackLetters(letterIndex: studentAssessmentitems![itemIndex!].items[index].itemIndex,letterId: studentAssessmentitems![itemIndex!].items[index].itemId,rules: rules))
        }
        print("Lesson " + String(lessonId!))
        let sendWordFeedback = SendWordFeedback(wordId: studentAssessmentitems![itemIndex!].word_id,studentId: studentId!, assignmentId: lessonId!, comments: comments.text,letters: letters)
        do {
            let feedbackBody = try JSONEncoder().encode(sendWordFeedback)
            urlRequest.httpBody = feedbackBody
        } catch  {}
        TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            do{
                let resp = try JSONDecoder().decode(sendResponse.self, from: data)
                print(resp)
                //tell user feedback is sent
                self.activityIndicator.stopAnimating()
                self.showToast(controller: self, message : "Feedback Sent!", seconds: 3.0)
                self.impact.impactOccurred()
            }catch let error{
                self.activityIndicator.stopAnimating()
                self.showToast(controller: self, message : "Feedback Sent!", seconds: 3.0)
                self.impact.impactOccurred()
                print("Error decoding",error)
            }
        }

    }
    @IBAction func submitLetterFeedback(_ sender: Any) {
        activityIndicator.startAnimating()
        let jsonUrlString = TaskManager.serverIP + "TeacherService/submitLetterFeedback"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var submitFeedback: SendLetterFeedback?
        var rules = [FeedbackRules]()
        if itemType == 0{
            for index in 0..<studentAssessmentitems![0].items[itemIndex!].rules.count{
                var rule = FeedbackRules(ruleId: -1,correct: -1)
                if studentAssessmentitems![0].items[itemIndex!].rules[index].correct != 1{
                    rule.correct = 0
                }else{
                    rule.correct = 1
                }
                rule.ruleId = studentAssessmentitems![0].items[itemIndex!].rules[index].ruleId
                rules.append(rule)
            }
            submitFeedback = SendLetterFeedback(itemId: (studentAssessmentitems?[0].items[itemIndex!].itemId)!, studentId: studentId!, assigmentId: lessonId!, comments: comments.text,rules: rules)
            do {
                let feedbackBody = try JSONEncoder().encode(submitFeedback)
                urlRequest.httpBody = feedbackBody
            } catch  {}
            TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
                guard let data = data else {return}
                do{
                    let resp = try JSONDecoder().decode(sendResponse.self, from: data)
                    print(resp)
                    //tell user feedback is sent
                    self.activityIndicator.stopAnimating()
                    self.showToast(controller: self, message : "Feedback Sent!", seconds: 3.0)
                    self.impact.impactOccurred()
                }catch let error{
                    self.activityIndicator.stopAnimating()
                    self.showToast(controller: self, message : "Feedback Sent!", seconds: 3.0)
                    self.impact.impactOccurred()
                    print("Error decoding",error)
                }
            }
        }else{
            submitWordFeedback()
        }
                delegate?.sendAssessmentsback(studentAssessmentitems: studentAssessmentitems!)
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
}
protocol  AppliedRulesVCDelegate{
    func sendAssessmentsback(studentAssessmentitems:[Test])
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
