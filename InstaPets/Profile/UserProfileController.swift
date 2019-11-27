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
    let cellId = "cellId"
    override func viewDidLoad() {
        super .viewDidLoad()

        collectionView?.backgroundColor = .white
        //set the title of the viewController
//        navigationItem.title = Auth.auth().currentUser?.uid
        fecthUser()
        /*register the collectionView*/
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        /*register the cell*/
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)



        //change the size of the thing to lower the sizer of the image
        
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader

        header.user = self.user

          //not correct
          //header.addSubview(UIImageView())

          return header
      }



    //MARK: header section of the app, profile, follower.....etc
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .purple
        cell.layer.borderColor = UIColor.black.cgColor
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
/*for the collectionView Cell*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-2) / 3
        return CGSize(width: width, height: width)
    }

    /*this function is only accesible in UserProfileViewController*/
    var user: User?
    fileprivate func fecthUser() {

        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value!)
            guard let dictionary = snapshot.value as? [String:Any] else {return}
//            let userName = dictionary["username"] as? String
            print(dictionary)
            self.user = User(dictionary: dictionary)
            
            self.navigationItem.title = self.user?.username
//            print(self.user!.profileImageUrl)
            self.collectionView?.reloadData()

        }



    }
}



