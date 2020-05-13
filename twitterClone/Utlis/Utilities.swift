//
//  Utilities.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/7/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit


class Utilities {
    
    
    static func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        

        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv = UIImageView()
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leadingAnchor, bottom: view.bottomAnchor,
                  paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.trailingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingLeft: 8, paddingBottom: 8)
        
        
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    
    static func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = UIColor.white
        let font =  UIFont.systemFont(ofSize: 17)
        tf.font = font
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        return tf
    }
    
    
    static func attributedButton(firstPart: String, secondPart: String) -> UIButton {
                
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [
            .font : UIFont.systemFont(ofSize: 16),
            .foregroundColor : UIColor.white
        ])

        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [
            .font : UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor : UIColor.white
        ]))
        
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }

}
