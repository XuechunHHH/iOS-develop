//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by mac on 6/14/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        // 1. Request & Session
        // 2. Response & Data
        // 3. Parsing & JSON Serialization
        
        // 1.
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=0e339060dd48106c2cb1cba5ae2442be")
        let session = URLSession.shared
        // Closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2.
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        // Async
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let cad = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(cad)"
                                }
                                if let cad = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(cad)"
                                }
                                if let cad = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(cad)"
                                }
                                if let cad = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(cad)"
                                }
                                if let cad = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(cad)"
                                }
                            }
                        }
                    } catch {
                        print ("ERROR")
                    }
                }
            }
        }
        task.resume()
    }
}

