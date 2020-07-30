//
//  UserService.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/20/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Firebase

struct UserService {
    static let shared = UserService()
    func fetchUser(uid: String, completion: @escaping (User)->()) {
            REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
                let user = User(dict: dictionary, uid: uid)
                completion(user)
            }
    }
    
    
}
