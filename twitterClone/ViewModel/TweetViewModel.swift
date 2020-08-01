//
//  TweetViewModel.swift
//  twitterClone
//
//  Created by mohamed elatabany on 7/30/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit


struct TweetViewModel {
    
    let tweet: Tweet
    let user: User

    
    
    
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    
    var profileImageUrl: URL? {
        return tweet.user.profileImageUrl
    }
    
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 14),
        ])
        title.append(NSMutableAttributedString(string: " @\(user.username.lowercased())  · \(timeStamp)", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.lightGray
        ]))
        
        
//        title.append(NSMutableAttributedString(string: ")", attributes: [
//            .font: UIFont.systemFont(ofSize: 14),
//            .foregroundColor: UIColor.lightGray
//        ]))
        
        
        
        return title
    }
    
    
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
}
