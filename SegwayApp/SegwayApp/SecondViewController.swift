//
//  SecondViewController.swift
//  SegwayApp
//
//  Created by mac on 6/1/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var myName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "name: \(myName)"
    }
    

}
