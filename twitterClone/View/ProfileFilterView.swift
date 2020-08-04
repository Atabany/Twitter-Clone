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
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    

}


extension ProfileFilterView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifeir, for: indexPath) as! ProfileFilterCell
        return cell
    }

}


extension ProfileFilterView: UICollectionViewDelegate {

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterView(self, didSelect: indexPath)
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

