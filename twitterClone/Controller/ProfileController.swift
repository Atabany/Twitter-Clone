
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
    
    private let user: User?
    
    
    
    
    
    
    
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
    
}

// -------------------------------------------------
// MARK: - Data Source

extension ProfileController {

    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
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
