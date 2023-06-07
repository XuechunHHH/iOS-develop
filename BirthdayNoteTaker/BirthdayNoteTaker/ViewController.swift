//
//  ViewController.swift
//  BirthdayNoteTaker
//
//  Created by mac on 6/1/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if let myName = storedName as? String {
            print(myName)
            nameLabel.text = "Name: \(myName)"
        } else {
            nameLabel.text = "Name:"
        }
        
        if let myBirthday = storedBirthday as? String {
            birthdayLabel.text = "Birthday: \(myBirthday)"
        } else {
            birthdayLabel.text = "Birthday:"
        }
    }


    @IBAction func saveClicked(_ sender: Any) {
        UserDefaults.standard.set(nameTextField.text!, forKey: "name")
        UserDefaults.standard.set(birthdayTextField.text!, forKey: "birthday")
        
        nameLabel.text = "Name: \(nameTextField.text!)"
        birthdayLabel.text = "Birthday: \(birthdayTextField.text!)"
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "birthday")
        nameLabel.text = "Name: "
        birthdayLabel.text = "Birthday: "
    }
}

