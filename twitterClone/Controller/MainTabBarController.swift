//
//  MainTabBarController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Firebase
import UIKit

class MainTabBarController: UITabBarController {
    
    
    // -------------------------------------------------
    // MARK: - Properties
        
    var user: User? {
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()

    
    
    // -------------------------------------------------
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
    }
    
    
    
    // -------------------------------------------------
    // MARK: - API
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureForUser()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Debug: Failed to sign out with erro \(error.localizedDescription)")
        }
    }

    
    func fetchUser() {
        UserService.shared.fetchUser() { user in
            self.user = user
        }
    }
    
    
    func configureForUser() {
        configureViewControllers()
        configureUI()
        fetchUser()
    }
    
    // -------------------------------------------------
    // MARK: - actions
    
    @objc func actionButtonTapped() {
        guard let user = user else { return }
        let controller = UploadTweetController(user: user)
        let nav =  UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
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
