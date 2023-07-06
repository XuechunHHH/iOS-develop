//
//  ViewController.swift
//  SnapChatClone
//
//  Created by mac on 7/5/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func SignInClicked(_ sender: Any) {
        if usernameText.text != "" && emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
                if error != nil {
                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "ERROR", message: "Email / Username / Password missing.")
        }
    }
    
    @IBAction func SignUpClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (auth, error) in
                if error != nil {
                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                } else {
                    let firestore = Firestore.firestore()
                    let userDic = ["email" : self.emailText.text!, "username" : self.usernameText.text!] as! [String : Any]
                    firestore.collection("UserInfo").addDocument(data: userDic) { error in
                        if error != nil {
                            self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                        }
                    }
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "ERROR", message: "Email / Username / Password missing.")
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
                                      
    }
    
}

