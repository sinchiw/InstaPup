//
//  Post.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/17/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    let user: User
    let caption: String


    init(user: User, dictionary: [String:Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
