//
//  SnapVC.swift
//  SnapChatClone
//
//  Created by mac on 7/5/23.
//

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap : Snap?
    var selectedTime : Int?
    var inputArr = [KingfisherSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let time = selectedTime {
            timeLabel.text = "Time Left: \(time)"
        }
        if let snap = selectedSnap {
            for imageURL in snap.imageUrlArr {
                inputArr.append(KingfisherSource(urlString: imageURL)!)
            }
            let imageSideshow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.9))
            imageSideshow.backgroundColor = UIColor.white
            imageSideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSideshow.setImageInputs(inputArr)
            self.view.addSubview(imageSideshow)
        }
        
    }

}
