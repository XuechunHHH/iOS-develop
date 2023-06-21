//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by mac on 6/15/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Kingfisher
import OneSignal

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var emailArr = [String]()
    var commentArr = [String]()
    var likeArr = [Int]()
    var imageArr = [String]()
    var idArr = [String]()
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    
        
        // Player IDs
        let status = OneSignal.getDeviceState()
        let newPlayerId = status?.userId!
        
        firestore.collection("PlayerId").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error == nil {
                if snapshot != nil && snapshot?.isEmpty == false {
                    var flag = false
                    for document in snapshot!.documents {
                        if let playerId = document.get("playerId") as? String{
                            // let documentId = document.documentID
                            if playerId == newPlayerId {
                                flag = true
                            }
                        }
                    }
                    if flag == false {
                        let playIdDic = ["email" : Auth.auth().currentUser!.email!, "playerId" : newPlayerId] as! [String : Any]
                        
                        self.firestore.collection("PlayerId").addDocument(data: playIdDic) { error in
                            if error != nil {
                                self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "ERROR")
                            }
                        }
                    }
                } else {
                    let playIdDic = ["email" : Auth.auth().currentUser!.email!, "playerId" : newPlayerId] as! [String : Any]
                    
                    self.firestore.collection("PlayerId").addDocument(data: playIdDic) { error in
                        if error != nil {
                            self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "ERROR")
                        }
                    }
                }
            } else {
                self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "ERROR")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = emailArr[indexPath.row]
        cell.commentLabel.text = commentArr[indexPath.row]
        let imageUrl = URL(string: imageArr[indexPath.row])
        // print(imageArr[indexPath.row])
        cell.userImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        cell.countLabel.text = String(likeArr[indexPath.row])
        cell.idLabel.text = idArr[indexPath.row]
        return cell
    }
    
    func getDataFromFirestore() {
        firestore.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "ERROR")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.emailArr.removeAll()
                    self.commentArr.removeAll()
                    self.imageArr.removeAll()
                    self.likeArr.removeAll()
                    self.idArr.removeAll()
                    for document in snapshot!.documents {
                        let id = document.documentID
                        self.idArr.append(id)
                        if let author = document.get("postedBy") as? String {
                            self.emailArr.append(author)
                        }
                        if let comment = document.get("postComment") as? String {
                            self.commentArr.append(comment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArr.append(likes)
                        }
                        if let image = document.get("imageUrl") as? String {
                            self.imageArr.append(image)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
