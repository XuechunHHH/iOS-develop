//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by mac on 6/16/23.
//

import UIKit
import FirebaseFirestore
import OneSignal

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        let firestore = Firestore.firestore()
        if let count = Int(countLabel.text!) {
            let post = ["likes" : count + 1] as [String: Any]
            firestore.collection("Posts").document(idLabel.text!).setData(post, merge: true)
        }
        firestore.collection("Posts").getDocuments { snapshot, error in
            if error == nil {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if let author = document.get("postedBy") as? String {
                            firestore.collection("PlayerId").whereField("email", isEqualTo: author).getDocuments { snapshot, error in
                                if error == nil {
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        var ids = [String]()
                                        for document in snapshot!.documents {
                                            if let id = document.get("playerId") as? String {
                                                ids.append(id)
                                            }
                                        }
                                        // Push notifications
                                        let content: [String : Any] = [
                                            "contents": ["en": "Someone likes your post!"],
                                            "headings": ["en": "New Information"],
                                            "include_player_ids": ids,
                                            "data" : ["action" : "custom_action"]
                                        ]
                                        OneSignal.postNotification(content,onSuccess: {
                                            osResultSuccessBlock in print(osResultSuccessBlock.debugDescription)
                                            },
                                            onFailure: {
                                              osFailureBlock in print(osFailureBlock.debugDescription)
                                        })
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
