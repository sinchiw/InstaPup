
//
//  HomeViewController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/26/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
                collectionView.backgroundColor = .white
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        setUpNavItem()
        fetchPosts()
    }

    func setUpNavItem(){
        navigationItem.title = "InstaPets"
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 40 + 8 + 8//username userprofielimageView
        height += view.frame.width
        height += 50
        height += 60
        return CGSize(width: view.frame.width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell

        cell.post = posts[indexPath.item]
        return cell
    }
    var posts = [Post]()
       fileprivate func fetchPosts(){
            guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.fetchUserWithUID(uid: uid)
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            print("the value of userdictionary", userDictionary)
            let user = User(uid: uid, dictionary: userDictionary)
//            print("user is", user.)
            self.fetchPostWithUser(user: user)
            print(snapshot.value!)


        }) { (err) in
            print("error", err)
        }




        }

    fileprivate func fetchPostWithUser(user: User){

//        guard let uid = Auth.auth().currentUser?.uid else {return}


        let ref = Database.database().reference().child("posts").child(user.uid)
                               ref.observeSingleEvent(of: .value, with: { (snapshot) in
                                   /*access dictionary */

                                   guard let dictionaries = snapshot.value as? [String: Any] else {return}


                                   dictionaries.forEach({ (key, value) in
                                       /*to seperat from each key*/
                       //                print("Key\(key), Value: \(value)")
                                       guard let dictionary = value as? [String:Any] else {return}
                       //                let imageUrl = dictionary["imageUrl"]as? String
                                       print("look at this ", dictionary)
                       //                print("imageUrl:\(imageUrl)")

                                       let post = Post(user: user, dictionary: dictionary)
                   //                    let post = Post(dictionary: dictionary)
                                       print(post.imageUrl)
                                       self.posts.append(post)
                                   })
                                   self.collectionView.reloadData()

                               })

                               { (error) in
                                   print("error", error)

                               }

    }
}

