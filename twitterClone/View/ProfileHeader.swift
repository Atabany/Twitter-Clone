//
//  ProfileHeader.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/1/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class  {
    func backButtonDidPressed()
}

class ProfileHeader: UICollectionReusableView {
    
    
    // -------------------------------------------------
    // MARK: - Properties
    
    
    
    
    weak var delegate: ProfileHeaderDelegate?
    
    
    private let filterBar = ProfileFilterView()
    
    
    
    
    private lazy var  containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .twitterBlue
        
        view.addSubview(self.backButton)
        self.backButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, paddingTop: 42, paddingLeft: 16)
        self.backButton.setDimensions(width: 30, height: 30)
        
        return view
    }()
    
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(self.handleDismissal), for: .touchUpInside)
        return button
    }()
    

    
    
    
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        iv.layer.cornerRadius = 80/2
        return iv
    }()
    
    lazy var editProfilefollowButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.layer.cornerRadius = 36 / 2

        button.addTarget(self, action: #selector(self.handleEditProfileFollow), for: .touchUpInside)
        return button
        
    }()
    
    
    
    
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Mohaemed Elatabany"
        return label
    }()
    
    
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@Atabany"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
    }()
    

        
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    
    // -------------------------------------------------
    // MARK: -  Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterBar.delegate = self
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, height: 108)
        
        
        
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: containerView.bottomAnchor, leading: leadingAnchor, paddingTop: -24, paddingLeft: 8)
        profileImageView.setDimensions(width: 80, height: 80)
        
        
        addSubview(editProfilefollowButton)
        editProfilefollowButton.anchor(top: containerView.bottomAnchor, trailing: trailingAnchor, paddingTop: 12, paddingRight: 12)
        
        editProfilefollowButton.setDimensions(width: 100, height: 36)
        
        
        
        let userDetailsStackView = UIStackView(arrangedSubviews: [fullNameLabel,userNameLabel, bioLabel])
        userDetailsStackView.axis = .vertical
        userDetailsStackView.distribution = .fillProportionally
        userDetailsStackView.alignment = .fill
        userDetailsStackView.spacing = 4
        self.addSubview(userDetailsStackView)
        
        
        userDetailsStackView.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        
        
        addSubview(filterBar)
        
        filterBar.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, height: 50)
        
        
        
        addSubview(underlineView)
        underlineView.anchor(leading: leadingAnchor, bottom: bottomAnchor, width: frame.width / 3, height: 2)
        
        
        
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // -------------------------------------------------
    // MARK: - selectors
    
    @objc
    func handleDismissal() {
        delegate?.backButtonDidPressed()
    }
    
    @objc
    func handleEditProfileFollow() {
        
    }
    
}

// -------------------------------------------------
// MARK: - ProfileFilterviewDelegate
extension ProfileHeader: ProfileFilterviewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else {
            return
        }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}
