//
//  User.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/20/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    let fullname: String
    let username: String
    var profileImageUrl: URL?
    let email: String
    let uid: String
    var stats: UserRelationStats?
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid ?? ""  == uid
    }
    
    var isFollowed = false
      
    
    
    init(dict: [String: AnyObject], uid: String) {
        self.fullname = (dict["fullname"]  as? String) ?? ""
        self.username = (dict["username"]  as? String) ?? ""
        self.email = (dict["email"]  as? String) ?? ""
        self.uid = uid
        if let profileImageUrlString = (dict["profileImageUrl"]  as? String) {
            self.profileImageUrl = URL(string: profileImageUrlString)
        }
    }
}


struct UserRelationStats {
    var followers: Int
    var followings: Int
}
