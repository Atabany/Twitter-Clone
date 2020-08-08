//
//  UserCell.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/8/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit


class UserCell: UITableViewCell {

    
    
    
    // -------------------------------------------------
    // MARK: - Properties
    var user: User? {
        didSet {
            self.configure()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 40, height: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    
    
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Username"
        return label
    }()
    
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "FullName"
        return label
    }()
    
    
    
    // -------------------------------------------------
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leadingAnchor, paddingLeft: 12)
        
        
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 3
        
        addSubview(stack)
        
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.trailingAnchor, paddingLeft: 12)
        
        
        

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // -------------------------------------------------
    // MARK: - Helpers
    
    func configure() {
        guard let user = user else {return}
        profileImageView.sd_setImage(with: user.profileImageUrl)
        usernameLabel.text = user.username
        fullnameLabel.text = user.fullname
    }
    
}
