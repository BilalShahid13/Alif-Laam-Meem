//
//  LoginVC.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 24/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit
import SQLite3
import Lottie
import AVFoundation

class LoginVC: UIViewController, UITextFieldDelegate{
    
    //User Choice Drop Down Menu Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userChoiceOutlet: UIButton!
    @IBOutlet var userChoiceOutletCollection: [UIButton]!
    /////////////////////////////////////
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet var animationView: LOTAnimationView!
    @IBOutlet weak var loginButton: UIButton!
    let impact = UIImpactFeedbackGenerator()
    var audioPlayer = AVAudioPlayer()
    var loginUser: User?
    var screenHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.delegate = self
        self.password.delegate = self
        
        userChoiceOutlet.layer.cornerRadius = 5
        userChoiceOutletCollection.forEach { (button) in
            button.layer.cornerRadius = 5
        }
        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.black.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        startAnimation()
    }
    //User Choice Drop Down Menu Actions
    @IBAction func userChoiceAction(_ sender: Any) {
        self.dismissKeyboard()
        userChoiceOutletCollection.forEach { (button) in
            UIView.animate(withDuration: 0.25, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func userChoiceActionCollection(_ sender: UIButton) {
        userChoiceOutlet.titleLabel?.text = sender.titleLabel?.text
        userChoiceOutletCollection.forEach { (button) in
            UIView.animate(withDuration: 0.25, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    ////////////////////////////////////////
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Teacher"{
            self.activityIndicator.stopAnimating()
            let destinationVC = segue.destination as! UINavigationController
            let targetVC = destinationVC.topViewController as! TeacherProfileViewController
            targetVC.teacher = self.loginUser
        }else{
            self.activityIndicator.stopAnimating()
            let destinationVC = segue.destination as! UINavigationController
            let targetVC = destinationVC.topViewController as! MenuViewController
            targetVC.Student = self.loginUser
        }
    }
    func checkUserCredentials(urlRequest: URLRequest,type: String){
        TaskManager.shared.dataTask(withRequest: urlRequest){ (data, response, error) in
            guard let data = data else {return}
            do {
                self.activityIndicator.stopAnimating()
                let resp = try JSONDecoder().decode(User.self, from: data)
                print(resp)
                self.loginUser = resp
                if(resp.id != -1){
                    if(type=="T"){
                        self.performSegue(withIdentifier: "Teacher", sender: self)
                    }else if(type=="S"){
                        self.performSegue(withIdentifier: "Student", sender: nil)
                    }else{
                        self.generateAlert(title: "Alert", message: "No User Found!")
                    }
                }
                else{
                    self.generateAlert(title: "Alert", message: "No User Found!")
                }
            } catch let error{
                print("Error decoding",error)
            }
        }
        
    }
    @IBAction func LoginButtonPressed(_ sender: Any) {
        guard let un = userName.text, !un.isEmpty else {
            generateAlert(title: "Alert", message: "Enter Username!")
            return
        }
        guard let pass = password.text, !pass.isEmpty else {
            generateAlert(title: "Alert", message: "Enter Password!")
            return
        }
        
        var type = userChoiceOutlet.titleLabel?.text
        if(type=="Teacher" || type=="Student"){
                        type = String(type!.first!)
            self.activityIndicator.startAnimating()
            let jsonUrlString = TaskManager.serverIP + "LoginService/checkCredentials"
            guard let url = URL(string: jsonUrlString) else {return}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod="POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let confirmUser = User(name: un, password: pass, userType: type ?? "",id: -1)
            do {
                let loginBody = try JSONEncoder().encode(confirmUser)
                urlRequest.httpBody = loginBody
            } catch  {}
            checkUserCredentials(urlRequest: urlRequest,type: type!)
            impact.impactOccurred()
            
        }
        else{
            generateAlert(title: "Alert", message: "Select User Type!")
        }
    }
    func generateAlert(title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func startAnimation(){
//        let asorce: URL!
//        asorce = Bundle.main.url(forResource: "Netflix Opening (1080p)", withExtension: "mp3")
//        do{
//            audioPlayer = try AVAudioPlayer.init(contentsOf: asorce!)
//            audioPlayer.play()
//        }catch{
//            print(error)
//        }
        animationView.setAnimation(named: "data")
        animationView.play()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
