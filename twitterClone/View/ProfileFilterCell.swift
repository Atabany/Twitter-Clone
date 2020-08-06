//
//  ProfileFilterCell.swift
//  twitterClone
//
//  Created by mohamed elatabany on 8/1/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    
    
    
    
    // -------------------------------------------------
    // MARK: - Properties
    
    var filterOption: ProfileFilterOption? {
        didSet {
            self.configure()
        }
    }

    
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "test filter"
        return label
     }()
    
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16): UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    // -------------------------------------------------
    // MARK: - LifeCycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // -------------------------------------------------
    // MARK: - Helpers
    
    func configure() {
        guard let option = self.filterOption else {return}
        titleLabel.text = option.description
    }
}
