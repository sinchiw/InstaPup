//
//  UserProfileController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 11/19/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class UserProfileViewController : UICollectionViewController {

    override func viewDidLoad() {
        super .viewDidLoad()

        collectionView?.backgroundColor = .white
        //set the title of the viewController
//        navigationItem.title = Auth.auth().currentUser?.uid
        fecthUser()



        //change the size of the thing to lower the sizer of the image
        
    }

    /*this function is only accesible in UserProfileViewController*/
    private func fecthUser() {

        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value!)
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            let userName = dictionary["username"] as? String
            self.navigationItem.title = userName
        }



    }
}
