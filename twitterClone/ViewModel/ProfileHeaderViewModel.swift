//
//  ProfileHeaderViewModel.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit


enum ProfileFilterOption: Int, CaseIterable {
    
    case tweets
    case replies
    case likes
    
    
    var description: String {
        switch  self {
        case .tweets:
            return "Tweets"
        case .replies:
            return "Tweets & Replies"
        case .likes:
            return "Likes"
        }
    }
    
    
    
}



struct ProfileHeaderViewModel {
    
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: 2, text: "Followers")
    }
    
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: 4, text: "Following")
    }
    
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return "Follow"
        }
    }
    
    
    func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 14)
        ])
        
        attributedTitle.append(NSMutableAttributedString(string: " \(text)", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.lightGray
        ]))
        
        return attributedTitle
    }
    
    
    
    
}
