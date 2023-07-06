//
//  UserSingleton.swift
//  SnapChatClone
//
//  Created by mac on 7/5/23.
//

import Foundation

class UserSingleton {
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init(){}
}
