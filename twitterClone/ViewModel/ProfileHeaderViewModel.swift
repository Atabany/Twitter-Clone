//
//  ProfileHeaderViewModel.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Foundation


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
