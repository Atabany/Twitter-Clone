//
//  AuthService.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/20/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Firebase
import UIKit

struct AuthService {
    
    static let shared = AuthService()
    
    
    typealias completion = ((Error?, DatabaseReference) -> ())

    func registerUser(credentials: AuthCredential, completion: @escaping completion) {
        
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        let fullname = credentials.fullName
        
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        
        let fileName = UUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                print("Debug: Error is \(error.localizedDescription)")
                return
            }
            
            
            storageRef.downloadURL { (url, error) in
                
                
                
                guard let profileImageURL = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("Debug: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    print("Debug: Successfully registered user")
                    
                    guard let uid = result?.user.uid else {return}
                    let values = [
                        "email": email,
                        "username": username,
                        "fullname": fullname,
                        "profileImageUrl": profileImageURL,
                    ]
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
    
    
    
    func logUserIN(email: String, password: String, completion: AuthDataResultCallback?) {
        print("Debug: Email is \(email), Password is \(password)")
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    
    
    
}

struct AuthCredential {
    let email: String
    let fullName: String
    let password: String
    let username: String
    let profileImage: UIImage
}
