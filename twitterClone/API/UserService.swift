//
//  UserService.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/20/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Firebase


typealias DatabaseCompletion = (Error?, DatabaseReference) -> Void


struct UserService {
    static let shared = UserService()
    func fetchUser(uid: String, completion: @escaping (User)->()) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            let user = User(dict: dictionary, uid: uid)
            completion(user)
        }
    }
    
    
    
    func fetchUsers(completion: @escaping ([User])->()) {
        var users = [User]()
        REF_USERS.observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            let user = User(dict: dictionary, uid: uid)
            users.append(user)
            completion(users)
        }
    }
    
    
    func followUser(uid: String, completion: @escaping DatabaseCompletion) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        REF_USERS_FOLLOWING.child(currentUid).updateChildValues([uid: 1]) { (err, ref) in
            
            REF_USERS_FOLLOWERS.child(uid).updateChildValues([currentUid: 1], withCompletionBlock: completion)
        }
    }
    
    func unfollowUser(uid: String, completion: @escaping DatabaseCompletion)  {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        REF_USERS_FOLLOWING.child(currentUid).child(uid).removeValue { (err, ref) in
            REF_USERS_FOLLOWERS.child(uid).child(currentUid).removeValue(completionBlock: completion)
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void ) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        REF_USERS_FOLLOWING.child(currentUid).child(uid).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping (UserRelationStats) -> Void) {        
        REF_USERS_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let followers = snapshot.children.allObjects.count
            
            REF_USERS_FOLLOWING.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                let following = snapshot.children.allObjects.count
                
                let stats = UserRelationStats(followers: followers, followings: following)
                completion(stats)
                
            }
        }

    }
    
}
