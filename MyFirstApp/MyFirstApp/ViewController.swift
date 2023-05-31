//
//  ViewController.swift
//  MyFirstApp
//
//  Created by mac on 5/31/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var metallicaLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeClicked(_ sender: Any) {
        imageView.image = UIImage(named: "Metallica2")
    }
    
}

