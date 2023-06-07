//
//  ViewController.swift
//  AlertProject
//
//  Created by mac on 6/2/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var password2Text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func signClicked(_ sender: Any) {
        if (usernameText.text == ""){
            makeAlert(title: "Error!", message: "Username not found!")
        } else if (passwordText.text == ""){
            makeAlert(title: "Error!", message: "Password not found!")
        } else if (passwordText.text != password2Text.text){
            makeAlert(title: "Error!", message: "Passwords do not match")
        } else {
            makeAlert(title: "Succcess!", message: "Signed up")
        }
    }
}

