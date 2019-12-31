//
//  User.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/30/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let profileImageUrl: String
    let uid: String
    init(uid:String, dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageURL"]  as? String ?? ""
        self.uid = uid

    }
}
