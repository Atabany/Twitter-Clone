//
//  ProfileFilterView.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/1/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

private let reuseIdentifeir = "ProfileFilterCell"

protocol ProfileFilterviewDelegate: class {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath)
}


class ProfileFilterView: UIView {
    
    
    
    // -------------------------------------------------
    // MARK: - Properties
    
    var delegate: ProfileFilterviewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifeir)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
        collectionView.isScrollEnabled = false
        
        
        
        let selectedIndex = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndex, animated: true, scrollPosition: .left)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension ProfileFilterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOption.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifeir, for: indexPath) as! ProfileFilterCell
        let option = ProfileFilterOption(rawValue: indexPath.row)
        cell.filterOption = option
        return cell
    }
    
}


extension ProfileFilterView: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        guard let lastIndexPath = collectionView.indexPathsForVisibleItems.last else {
            return
        }

        guard let firstIndexPath = collectionView.indexPathsForVisibleItems.first else {
            return
        }
        
        
        if lastIndexPath == indexPath || firstIndexPath == indexPath  {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.250) {
            self.delegate?.filterView(self, didSelect: indexPath)
        }
        
        
    }
    
    
}

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width / 3 , height: frame.height)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

