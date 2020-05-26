//
//  Constants.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/20/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")




let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")











































