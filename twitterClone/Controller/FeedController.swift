//
//  FeedController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class FeedController: UIViewController {

    // -------------------------------------------------
    // MARK: - Properties
    
    
    // -------------------------------------------------
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

     // -------------------------------------------------
    // MARK: - Helpers
    
    func configureUI() {
        self.view.backgroundColor = UIColor.systemFill
        let image = UIImageView(image: UIImage(named: "twitter_logo_blue")!)
        image.contentMode = .scaleAspectFit
        self.navigationItem.titleView = image
    }


}
