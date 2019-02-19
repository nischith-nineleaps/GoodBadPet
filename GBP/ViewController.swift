//
//  ViewController.swift
//  GBP
//
//  Created by Nineleaps on 09/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import ObjectMapper
import AlamofireObjectMapper
import Poi



class ViewController: UIViewController {
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var pwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userName {
            textField.resignFirstResponder()
                textField.becomeFirstResponder()
        }
//         else if textField == pwd {
//            textField.resignFirstResponder()
//        }
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
 
    
    @IBAction func onClickSubmitButton(_ sender: Any) {
//        userName.text = "JohnDoe"
//        pwd.text = "nineleaps"
        let parameters: [String: Any] = [ "username" : userName.text! , "password" :  pwd.text!]
     //   let urlString = URL(string: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/login")
        let alamofire = AlamofireWrapper()
        alamofire.callAlamofireTokenResponse(nameOfOperation: "login", parameters: parameters, headers: nil) { (response) -> (Void) in
            print("STATUS CODE:\(response.response?.statusCode)")
            if response.response?.statusCode == 200
            {
                let tokenStorage = response.result.value
                let token = tokenStorage?.response?.responseData?.token!
                let tokenSaveSuccessful: Bool = KeychainWrapper.standard.set(token!, forKey: "userToken")
                if tokenSaveSuccessful == true
                {
                    self.performSegue(withIdentifier: "SegueToMainPage" , sender: ViewController.self)
                }
            }
            else if response.response?.statusCode != 404
            {
                self.displayLoginAlert(title: "Login Failed", message: "Invalid credentials. Please try again.")
            }
            else if response.response?.statusCode == 400
            {
                self.displayLoginAlert(title: "Login Failed", message: "Incorrect username. User does not exist. Please try again.")
            }
        }
    }
    
    func displayLoginAlert (title: String?, message: String?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //POI CODE STARTS HERE
    
    
    
}
