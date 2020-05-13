//
//  ExploreViewController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    
    
    func configureUI() {
        self.view.backgroundColor = UIColor.systemBlue
        navigationItem.title = "Explore"
    }

}
