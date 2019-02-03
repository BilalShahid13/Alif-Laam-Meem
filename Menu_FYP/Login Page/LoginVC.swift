//
//  LoginVC.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 24/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    var loginUser: User?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Teacher"{
            let destinationVC = segue.destination as! UINavigationController
            let targetVC = destinationVC.topViewController as! TeacherProfileViewController
            targetVC.teacher = self.loginUser
        }else{
            let destinationVC = segue.destination as! UINavigationController
            let targetVC = destinationVC.topViewController as! MenuViewController
            targetVC.Student = self.loginUser
        }
    }
    func checkUserCredentials(urlRequest: URLRequest,type: String){
        TaskManager.shared.dataTask(withRequest: urlRequest){ (data, response, error) in
            guard let data = data else {return}
            do {
                let resp = try JSONDecoder().decode(User.self, from: data)
                print(resp)
                self.loginUser = resp
                if(resp.id != -1){
                    if(type=="T"){
                        self.performSegue(withIdentifier: "Teacher", sender: self)
                    }else if(type=="S"){
                        self.performSegue(withIdentifier: "Student", sender: nil)
                    }else{
                        let alert = UIAlertController(title: "Alert", message: "No User Found", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else{
                    let alert = UIAlertController(title: "Alert", message: "No User Found", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } catch let error{
                print("Error decoding",error)
            }
        }
        
    }
    @IBAction func LoginButtonPressed(_ sender: Any) {
        guard let un = userName.text, !un.isEmpty else {
            return
        }
        guard let pass = password.text, !pass.isEmpty else {
            return
        }
        
        let type:String?=un.components(separatedBy: "-")[0]
        if(type=="T" || type=="S"){
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
            
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "wrong username format", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
