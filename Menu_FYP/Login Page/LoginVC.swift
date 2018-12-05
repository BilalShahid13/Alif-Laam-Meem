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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func Login(withRequest urlRequest: URLRequest){
        URLSession.shared.dataTask(with: urlRequest) { (data, _, _) in
            guard let data = data else {return}
            do {
                var confirmUser = User(name: "", password: "", userType: "")
                let resp = try JSONDecoder().decode(User.self, from: data)
                print(resp)
                confirmUser.name=resp.name
                confirmUser.password=resp.password
                confirmUser.userType=resp.userType
                DispatchQueue.main.async {
                    if(confirmUser.name != "" && confirmUser.password != "" && confirmUser.userType != ""){
                        if(confirmUser.userType=="T"){
                            self.performSegue(withIdentifier: "Teacher", sender: nil)
                        }else if(confirmUser.userType=="S"){
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
                }
            } catch let error{
                print("Error decoding",error)
            }
            }.resume()
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
            let jsonUrlString = "http://192.168.8.101:8080/rest/LoginService/checkCredentials"
            guard let url = URL(string: jsonUrlString) else {return}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod="POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let confirmUser = User(name: un, password: pass, userType: type ?? "")
            do {
                let loginBody = try JSONEncoder().encode(confirmUser)
                urlRequest.httpBody = loginBody
            } catch  {}
            Login(withRequest: urlRequest)
            
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "wrong username format", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
