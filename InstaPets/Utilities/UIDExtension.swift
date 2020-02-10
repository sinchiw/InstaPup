//
//  UIDExtension.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/30/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

extension Database {
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        print("Fecthing user with uid", uid)
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

                    guard let userDictionary = snapshot.value as? [String: Any] else {return}
                    print("the value of userdictionary", userDictionary)
                    let user = User(uid: uid, dictionary: userDictionary)
        //            print("user is", user.)
//            print(user.username)
            completion(user)
//                    self.fetchPostWithUser(user: user)
                    print(snapshot.value!)


                }) { (err) in
                    print("error", err)
                }

    }
}
