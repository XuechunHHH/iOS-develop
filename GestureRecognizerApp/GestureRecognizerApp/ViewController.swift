//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by mac on 6/2/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        
        let gestureRecoginzer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        imageView.addGestureRecognizer(gestureRecoginzer)
    }

    @objc func changePic(){
        if imageView.image == UIImage(named: "hjl1") {
            imageView.image = UIImage(named: "yyq1")
            nameLabel.text = "Yiqi"
        } else {
            imageView.image = UIImage(named: "hjl1")
            nameLabel.text = "Jiale"
        }
    }
}

