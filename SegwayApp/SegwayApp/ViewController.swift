//
//  ViewController.swift
//  SegwayApp
//
//  Created by mac on 6/1/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var nameText: UITextField!
    
    var userName = ""
    
    override func viewDidLoad() {
        print("ViewDidDLoad function called")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("ViewDidDisappear function called")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("ViewWillDisappear function called")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewWillAppear function called")
        nameText.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("ViewDidAppear function called")
    }

    @IBAction func nextClicked(_ sender: Any) {
        userName = nameText.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.myName = userName
        }
    }
}

