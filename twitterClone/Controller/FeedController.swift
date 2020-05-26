//
//  FeedController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit
import SDWebImage
class FeedController: UIViewController {

    // -------------------------------------------------
    // MARK: - Properties
    var user: User? {
        didSet {
            self.configureLeftBarButton()
        }
    }
    
    // -------------------------------------------------
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // -------------------------------------------------
    // MARK: - Helpers
    
    func configureUI() {
        self.view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue")!)
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        self.navigationItem.titleView = imageView
    }
    
    
    func configureLeftBarButton() {
        guard let user = self.user else {return}
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    
    


}
