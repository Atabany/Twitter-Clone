//
//  LoginController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/5/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    

    // -------------------------------------------------
    // MARK: - Properties
    private let logoImage: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: self.emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: self.passwordTextField)
        return view
    }()

    private var emailTextField: UITextField  = {
        let tf = Utilities.textField(withPlaceholder: "Email")
        return tf
    }()
    
    private var passwordTextField: UITextField  = {
         let tf = Utilities.textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities.attributedButton(firstPart: "Don't have account?", secondPart: " Sign up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    
    
    // -------------------------------------------------
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // -------------------------------------------------
    // MARK: - actions
    @objc
    func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        AuthService.shared.logUserIN(email: email, password: password) { (ref, error) in
            if let err = error {
                print("Debug: error ... \(err.localizedDescription)")
                return
            }
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let tab = window.rootViewController as? MainTabBarController else {return}
            tab.configureForUser()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    func handleShowSignUp() {
        let vc = RegisterationController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    // -------------------------------------------------
    // MARK: - Helpers
    func configureUI() {
        self.view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true




        self.view.addSubview(logoImage)
        self.logoImage.setDimensions(width: 150, height: 150)
        self.logoImage.centerX(inView: self.view, topAnchor: self.view.topAnchor, paddingTop: 50)

        
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView, loginButton])
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .fillEqually
        self.view.addSubview(stack)
        
        stack.anchor(top: self.logoImage.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 30, paddingLeft: 32, paddingRight: 32)
        
        
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: self.view)
        dontHaveAccountButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    
    
    
}
