//
//  TweetCell.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/28/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit
class TweetCell: UICollectionViewCell {
    
    
    // -------------------------------------------------
    // MARK: - Properties
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48/2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Atabany @atab"
        return label
    }()
    
    
    private let infoLabel: UILabel = UILabel()

    
    
    
    
    
    // -------------------------------------------------
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        backgroundColor = .white
        
        
        
        addSubview(profileImageView)
        profileImageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            paddingTop: 12,
            paddingLeft: 8
        )
        
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        infoLabel.text = "Ebrahim Elatabany"
        infoLabel.font = UIFont.systemFont(ofSize: 14)

        
//        addSubview(infoLabel)
        addSubview(stack)
        let underlineView = UIView()

        
        underlineView.backgroundColor =  .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, height: 1)
        
        stack.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, bottom: underlineView.topAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        
        
        
        let actionStack = 
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
         
    
    // -------------------------------------------------
    // MARK: - Buttons
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    
  
    
    
    
    
    // -------------------------------------------------
    // MARK: - Selectors
    
    @objc
    func handleLikeTapped() {
        
        
        
    }
    
    @objc
    func handleCommentTapped() {
        
        
        
    }
    
    @objc
    func handleRetweetTapped() {
        
        
        
    }
    
    @objc
    func handleShareTapped() {
        
        
        
    }
    

    
    
    
    
    // -------------------------------------------------
    // MARK: - Helpers
    
    
    
    
}
