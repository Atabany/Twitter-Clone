//
//  MainTabBarController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    // -------------------------------------------------
    // MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        return button
    }()

    
    
    // -------------------------------------------------
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink
        configureViewControllers()
        configureUI()
    }
    
    
    // -------------------------------------------------
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(top: nil, left: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
        
    }
    
    
    
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let navFeed = templateNav(image: UIImage(named: "home_unselected")!, rootViewController: feed)
        
        let explore = ExploreController()
        let navExplore = templateNav(image: UIImage(named: "search_unselected")!, rootViewController: explore)
        
        let notifications = NotificationsController()
        let navNotifications = templateNav(image: UIImage(named: "like_unselected")!, rootViewController: notifications)
        
        
        
        let conversations = ConversationsController()
        let navConversations = templateNav(image: UIImage(named: "ic_mail_outline_white_2x-1")!, rootViewController: conversations)
        
        
        
        
        viewControllers = [
            navFeed,
            navExplore,
            navNotifications,
            navConversations
        ]
        
        
    }
    
    func templateNav(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = NavBarTheme.tint
        return nav
    }
}




struct TabBarTheme {
    static let tint = UIColor.white
}

struct NavBarTheme {
    static let tint = UIColor.white
}
