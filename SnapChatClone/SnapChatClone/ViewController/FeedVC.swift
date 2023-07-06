//
//  FeedVC.swift
//  SnapChatClone
//
//  Created by mac on 7/5/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let firestore = Firestore.firestore()
    var snapArr = [Snap]()
    var chosenSnap : Snap?
    var timeLeft : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        getSnapsFromFirebase()
        getUserInfo()
    }
    
    func getSnapsFromFirebase() {
        firestore.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.snapArr.removeAll()
                    for document in snapshot!.documents {
                        let id = document.documentID
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArr = document.get("imageUrlArr") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        if difference >= 24 {
                                            // Delete
                                            self.firestore.collection("Snaps").document(id).delete { error in
                                                if error != nil {
                                                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                                                }
                                            }
                                        }
                                        // TimeLeft -> SnapVC
                                        self.timeLeft = 24 - difference
                                    }
                                    let snap = Snap(username: username, imageUrlArr: imageUrlArr, date: date.dateValue())
                                    self.snapArr.append(snap)
                                    
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getUserInfo() {
        firestore.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.username = username
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
                                      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedUsernameLabel.text = snapArr[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArr[indexPath.row].imageUrlArr[0]),placeholderImage: UIImage(named: "placeholder"))
        print(snapArr[indexPath.row].imageUrlArr)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destinationVC = segue.destination as! SnapVC
            destinationVC.selectedSnap = self.chosenSnap
            destinationVC.selectedTime = self.timeLeft
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArr[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
}
