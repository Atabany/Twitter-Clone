//
//  TweetService.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/26/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Foundation
import Firebase


struct TweetService {
    
    static let shared = TweetService()
    
    
    
    func uploadTweet(caption: String, completion: @escaping ((Error?, DatabaseReference) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values = [
            "caption": caption,
            "likes": 0,
            "retweets": 0,
            "uid": uid,
            "timestamp": Int(Date().timeIntervalSince1970)
        ] as [String: Any]
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
}
