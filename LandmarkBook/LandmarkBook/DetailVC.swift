//
//  DetailVC.swift
//  LandmarkBook
//
//  Created by mac on 6/6/23.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var landmarkLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedLandmarkName = ""
    var selectedLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        landmarkLabel.text = selectedLandmarkName
        imageView.image = selectedLandmarkImage
    }
    

}
