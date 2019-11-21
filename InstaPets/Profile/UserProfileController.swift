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

struct User {
    let username: String
    let profileImageUrl: String

    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageURL"]  as? String ?? ""
    }
}

class UserProfileController : UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super .viewDidLoad()

        collectionView?.backgroundColor = .white
        //set the title of the viewController
//        navigationItem.title = Auth.auth().currentUser?.uid
        fecthUser()
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
    


        //change the size of the thing to lower the sizer of the image
        
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader

        header.user = self.user

          //not correct
          //header.addSubview(UIImageView())

          return header
      }




     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }

    /*this function is only accesible in UserProfileViewController*/
    var user: User?
    fileprivate func fecthUser() {

        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value!)
            guard let dictionary = snapshot.value as? [String:Any] else {return}
//            let userName = dictionary["username"] as? String
            self.user = User(dictionary: dictionary)
            
            self.navigationItem.title = self.user?.username
            print(self.user!.profileImageUrl)
            self.collectionView?.reloadData()

        }



    }
}



