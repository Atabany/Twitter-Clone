//
//  User.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/20/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Foundation
struct User {
    let fullname: String
    let username: String
    var profileImageUrl: URL?
    let email: String
    let uid: String
    
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
