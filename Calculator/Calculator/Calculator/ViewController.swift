//
//  ViewController.swift
//  Calculator
//
//  Created by mac on 5/31/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstText: UITextField!
        
    @IBOutlet weak var secondText: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var result: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sumClicked(_ sender: Any) {
        if let firstNumber = Int(firstText.text!), let secondNumber = Int(secondText.text!){
                result = firstNumber + secondNumber
                resultLabel.text = String(result)
        } else {
            resultLabel.text = "Input is not valid"
        }
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        if let firstNumber = Int(firstText.text!), let secondNumber = Int(secondText.text!){
                result = firstNumber - secondNumber
                resultLabel.text = String(result)
        } else {
            resultLabel.text = "Input is not valid"
        }
    }
    
    @IBAction func multiplyClicked(_ sender: Any) {
        if let firstNumber = Int(firstText.text!), let secondNumber = Int(secondText.text!){
                result = firstNumber * secondNumber
                resultLabel.text = String(result)
        } else {
            resultLabel.text = "Input is not valid"
        }
    }
    
    @IBAction func divideClicked(_ sender: Any) {
        if let firstNumber = Int(firstText.text!), let secondNumber = Int(secondText.text!){
                result = firstNumber / secondNumber
                resultLabel.text = String(result)
        } else {
            resultLabel.text = "Input is not valid"
        }
    }
}

