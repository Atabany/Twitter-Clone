//
//  ProfileHeader.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/1/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    
    // -------------------------------------------------
    // MARK: - Properties
    
    
    
    // -------------------------------------------------
    // MARK: -  Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .red
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
