//
//  UploadVC.swift
//  SnapChatClone
//
//  Created by mac on 7/5/23.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func choosePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data) { metadata, error in
                if error != nil {
                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                } else {
                    imageRef.downloadURL { url, error in
                        if error != nil {
                            self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                        } else {
                            let imageUrl = url?.absoluteString
                            
                            // Firestore
                            
                            let firestore = Firestore.firestore()
                            
                            firestore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.username).getDocuments { snapshot, error in
                                if error != nil {
                                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                                } else {
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        for document in snapshot!.documents {
                                            let documentId = document.documentID
                                            if var imageUrlArr = document.get("imageUrlArr") as? [String] {
                                                imageUrlArr.append(imageUrl!)
                                                let addDic = ["imageUrlArr" : imageUrlArr] as! [String : Any]
                                                firestore.collection("Snaps").document(documentId).setData(addDic, merge: true) { error in
                                                    if error == nil {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.imageView.image = UIImage(named: "selectImage")
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        let snapDic = ["imageUrlArr" : [imageUrl!], "snapOwner" : UserSingleton.sharedUserInfo.username, "date" : FieldValue.serverTimestamp()] as [String : Any]
                                        firestore.collection("Snaps").addDocument(data: snapDic) { error in
                                            if error != nil {
                                                self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                                            } else {
                                                self.tabBarController?.selectedIndex = 0
                                                self.imageView.image = UIImage(named: "selectImage")
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            
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
    
}
