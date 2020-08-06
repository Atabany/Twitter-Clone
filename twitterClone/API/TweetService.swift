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

        REF_TWEETS.childByAutoId().updateChildValues(values) { (error, ref) in
            guard let tweetId = ref.key else {return}
            REF_USERS_TWEETS.child(uid).updateChildValues([tweetId:1], withCompletionBlock: completion)
        }
        
        
    }
    
    
    func fetchTweets(completion: @escaping (([Tweet]) -> Void)) {
        var tweets = [Tweet]()
        REF_TWEETS.observe(.childAdded) { (snapshot) in
            print("Debug: snapshot \(snapshot)")
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            UserService.shared.fetchUser(uid:uid ) { (user) in
                let tweet = Tweet(user: user, tweetID: tweetID , dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
