//
//  RegisterationController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/5/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit
import Firebase

class RegisterationController: UIViewController {
    
    // -------------------------------------------------
    // MARK: - Properties
    let imagePicker = UIImagePickerController()
    private var profileImage: UIImage? = nil
    
    private let plussPhotoImage: UIButton =  {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "plus_photo")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(handleAddProfileImage), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities.attributedButton(firstPart: "Already have account?", secondPart: " Login")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: self.emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: self.passwordTextField)
        return view
    }()
    
    
    private lazy var fullNameContainerView: UIView = {
        let iamge = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities.inputContainerView(withImage:iamge, textField: self.fullNameTextField)
        return view
    }()
    
    
    private lazy var usernameContainerView: UIView = {
        let iamge = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities.inputContainerView(withImage:iamge, textField: self.userNameTextField)
        return view
    }()
    
    
    
    
    
    
    private var fullNameTextField: UITextField  = {
        let tf = Utilities.textField(withPlaceholder: "Full Name")
        return tf
    }()
    
    private var userNameTextField: UITextField  = {
        let tf = Utilities.textField(withPlaceholder: "Username")
        return tf
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
    
    
    
    
    
    // -------------------------------------------------
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // -------------------------------------------------
    // MARK: - Helpers
    func configureUI() {
        self.view.backgroundColor = .twitterBlue
        
        
        self.view.addSubview(plussPhotoImage)
        self.plussPhotoImage.setDimensions(width: 128, height: 128)
        self.plussPhotoImage.centerX(inView: self.view, topAnchor: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        
        let stack = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            fullNameContainerView,
            usernameContainerView,
            signUpButton])
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .fillEqually
        self.view.addSubview(stack)
        
        stack.anchor(top: self.plussPhotoImage.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: self.view)
        alreadyHaveAccountButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    // -------------------------------------------------
    // MARK: - Selectors
    
    @objc
    func handleShowLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func handleSignUp() {
        guard let profileImg = profileImage else {
            print("Debug: Please select a profile image")
            return
        }
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let username = userNameTextField.text else {return}
        guard let fullName = fullNameTextField.text else {return}
        
        let credentials = AuthCredential(email: email, fullName: fullName, password: password, username: username, profileImage: profileImg)
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let tab = window.rootViewController as? MainTabBarController else {return}
            tab.configureForUser()
            self.dismiss(animated: true, completion: nil)
        }
    }
        
    @objc
    func handleAddProfileImage() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}



extension RegisterationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate   {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard  let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        plussPhotoImage.layer.cornerRadius = 128 / 2
        plussPhotoImage.layer.masksToBounds = true
        plussPhotoImage.imageView?.contentMode = .scaleToFill
        plussPhotoImage.imageView?.clipsToBounds = true
        plussPhotoImage.layer.borderColor = UIColor.white.cgColor
        plussPhotoImage.layer.borderWidth = 3
        self.plussPhotoImage.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
}
