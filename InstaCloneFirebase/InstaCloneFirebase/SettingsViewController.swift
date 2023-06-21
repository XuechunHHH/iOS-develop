//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by mac on 6/15/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import OneSignal

class SettingsViewController: UIViewController {
    let firebase = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        let status = OneSignal.getDeviceState()
        let playerId = status?.userId!
        
        firebase.collection("PlayerId").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "ERROR")
            } else {
                if snapshot != nil && snapshot!.isEmpty == false {
                    for document in snapshot!.documents {
                        
                        if let id = document.get("playerId") as? String {

                            if id == playerId {
                                let documentId = document.documentID
                                print(documentId)
                                self.firebase.collection("PlayerId").document(documentId).delete(completion: { error in
                                    if error != nil {
                                        self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "ERROR")
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("Log out fails.")
        }
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}
