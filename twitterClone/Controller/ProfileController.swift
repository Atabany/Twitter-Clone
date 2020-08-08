
//
//  ProfileController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/1/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "ProfileHeader"


class ProfileController: UICollectionViewController {
    
    
    // -------------------------------------------------
    // MARK: - Properties
    
    private var user: User!
    private var tweets = [Tweet]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    
    
    
    
    
    // -------------------------------------------------
    // MARK: - LifeCycle
    
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchTwetes()
        checkIfUserIsFollowed()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    
    
    
    
    // -------------------------------------------------
    // MARK: - Helpers
    
    func configureCollectionView() {
        
        
        
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
        
    }
    // -------------------------------------------------
    // MARK: - API
    func fetchTwetes() {
        guard let user = self.user else {return}
        TweetService.shared.fetchTweets(forUser: user) { (tweets) in
            // THE TABLEVIEW STUFF
            self.tweets = tweets
        }
    }
    
    
    func checkIfUserIsFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { (isFollowed) in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
}

// -------------------------------------------------
// MARK: - Data Source

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        //        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
}

// MARK: - CollectionView Delegate
extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        header.user = self.user
        return header
    }
    
    
    
}


extension ProfileController: ProfileHeaderDelegate {
    func handleEditProfileFollow(_ header: ProfileHeader) {
        
        
        
        if user.isCurrentUser {
            print("DEBUG: show edit profile controller ")
            return
        }
        
        
        
        if user.isFollowed {
            UserService.shared.unfollowUser(uid: user?.uid ?? "") { (_, _) in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        } else {
            
            
            UserService.shared.followUser(uid: user?.uid ?? "") { (_, _) in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
        
        
        
        
        
    }
    
    func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

// -------------------------------------------------
// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width , height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    
    
    
}
