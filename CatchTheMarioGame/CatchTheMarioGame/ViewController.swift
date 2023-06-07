//
//  ViewController.swift
//  CatchTheMarioGame
//
//  Created by mac on 6/3/23.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var former = 0
    var highScore = 0
    
    var timer = Timer()
    var counter = 0
    var marioArr = [UIImageView]()
    var hideTimer = Timer()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var mario1: UIImageView!
    @IBOutlet weak var mario2: UIImageView!
    @IBOutlet weak var mario3: UIImageView!
    @IBOutlet weak var mario4: UIImageView!
    @IBOutlet weak var mario5: UIImageView!
    @IBOutlet weak var mario6: UIImageView!
    @IBOutlet weak var mario7: UIImageView!
    @IBOutlet weak var mario8: UIImageView!
    @IBOutlet weak var mario9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "Score: \(score)"
        
        // HighSocre
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil{
            highScore = 0
        } else {
            highScore = (storedHighscore as? Int)!
        }
        highScoreLabel.text = "Highscore: \(highScore)"
        
        // Images
        mario1.isUserInteractionEnabled = true
        mario2.isUserInteractionEnabled = true
        mario3.isUserInteractionEnabled = true
        mario4.isUserInteractionEnabled = true
        mario5.isUserInteractionEnabled = true
        mario6.isUserInteractionEnabled = true
        mario7.isUserInteractionEnabled = true
        mario8.isUserInteractionEnabled = true
        mario9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseSco))
        
        mario1.addGestureRecognizer(recognizer1)
        mario2.addGestureRecognizer(recognizer2)
        mario3.addGestureRecognizer(recognizer3)
        mario4.addGestureRecognizer(recognizer4)
        mario5.addGestureRecognizer(recognizer5)
        mario6.addGestureRecognizer(recognizer6)
        mario7.addGestureRecognizer(recognizer7)
        mario8.addGestureRecognizer(recognizer8)
        mario9.addGestureRecognizer(recognizer9)
        
        marioArr = [mario1, mario2, mario3, mario4, mario5, mario6, mario7, mario8, mario9]
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
        
        hideMario()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMario), userInfo: nil, repeats: true)
        
    }

    @objc func increaseSco(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            //Highscore
            if(self.score > self.highScore){
                self.highScore = self.score
                self.highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            // Alert
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) { UIAlertAction in
                self.marioArr[self.former].isUserInteractionEnabled = false
            }
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10;
                self.timeLabel.text = "Time: \(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideMario), userInfo: nil, repeats: true)
            }
            alert.addAction(noButton)
            alert.addAction(replay)
            self.present(alert, animated: true)
        }
    }
    
    @objc func hideMario(){
        for mario in marioArr {
            mario.isHidden = true
        }
        var random = former
        while(random == former){
            random = Int(arc4random_uniform(UInt32(marioArr.count - 1)))
        }
        former = random
        marioArr[random].isHidden = false
    }

}

