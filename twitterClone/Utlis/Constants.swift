//
//  Constants.swift
//  twitterClone
//
//  Created by mohamed elatabany on 5/20/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")





let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")
let REF_USERS_TWEETS = DB_REF.child("users-tweets")
let REF_USERS_FOLLOWERS = DB_REF.child("users-followers")
let REF_USERS_FOLLOWING = DB_REF.child("users-following")












































