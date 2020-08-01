//
//  FeedController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "cellid"

class FeedController: UICollectionViewController {

    // -------------------------------------------------
    // MARK: - Properties
    var user: User? {
        didSet {
            self.configureLeftBarButton()
        }
    }
    
    
    private var tweets = [Tweet]()
    
    
    // -------------------------------------------------
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }

    // -------------------------------------------------
    // MARK: - Helpers
    
    func configureUI() {
        self.collectionView.backgroundColor = .white
        self.view.backgroundColor = .white
        
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue")!)
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        self.navigationItem.titleView = imageView
        
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
    
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { (tweets) in
            self.tweets  = tweets
            self.collectionView.reloadData()
        }
    }
    
    

}



// -------------------------------------------------
// MARK: - UICollectionViewDelegate/DataSource

extension FeedController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = self.tweets[indexPath.row]
        cell.delegate = self
        return cell
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}


// -------------------------------------------------
// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width , height: 120)
    }
}



extension FeedController: TweetCellDelegate {
    
    func imageDidPressed(tweet: Tweet) {
        let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
