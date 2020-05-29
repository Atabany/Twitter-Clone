//
//  CaptionText.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/25/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class CaptionTextView: UITextView {
    
    let placeholderLabel: UILabel = {
        let l = UILabel()
        l.text = "What's happening?"
        l.font = UIFont.systemFont(ofSize: 16)
        l.textColor = .darkGray
        
        return l
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .white
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, leading: leadingAnchor, paddingTop: 8, paddingLeft: 4)
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 600).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc
    func handleTextInputChange() {
        UIView.animate(withDuration: 0.2) {
            self.placeholderLabel.alpha = self.text.isEmpty ? 1 : 0
        }
    }
    
}


