//
//  UploadTweetController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/25/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class UploadTweetController: UIViewController {

    //--------------------------------------
    // MARK: - Properties
    private lazy var actionButton: UIButton = {
        let button  = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48/2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    

    
    private let user: User?
    
    private let captionTextView = CaptionTextView()
    
    
    //--------------------------------------
    // MARK: - Variables
    
    
    
    
    //--------------------------------------
    // MARK: - LifeCycle
    
    init(user: User) {
        
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
        
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitial()
        profileImageView.sd_setImage(with: user?.profileImageUrl, completed: nil)
        
    }
    
    //--------------------------------------
    // MARK: - Initials
    func setupInitial() {
        configureUI()
    }
    
    func configureLeftBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }

    func configureRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.actionButton)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .top
        view.addSubview(stack)


        stack.anchor(
                    top: view.safeAreaLayoutGuide.topAnchor,
                    leading: view.leadingAnchor,
                    trailing: view.trailingAnchor,
                    paddingTop: 16,
                    paddingLeft: 16,
                    paddingRight: 16)
        
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        configureLeftBarButton()
        configureRightBarButton()
    }
    
    

    
    //--------------------------------------
    // MARK: - UI Updates
    
    
    
    //--------------------------------------
    // MARK: - UI Actions
    
    @objc
    func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc
    func handleUploadTweet() {
        guard let caption = captionTextView.text, !caption.isEmpty else {return}
        TweetService.shared.uploadTweet(caption: caption) { (error, ref) in
            if let error = error {
                print("Debug: Find an error \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    
    
    
    
    //--------------------------------------
    // MARK: - Logic
    
    
    //--------------------------------------
    // MARK: - Get/Send Data
    
    
    
    //--------------------------------------
    // MARK: - Helper Functions
    

    
}
