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




class UserProfileController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var posts = [Post]()
    var userId : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundColor()
        fecthUser()
        registerCollectionView()
        setupLogOutButton()
//        fetchPosts()
//        setupEditButton()
//        fetchOrderPost()

        //change the size of the thing to lower the sizer of the image
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
// fetchOrderPost()
    }

    func backgroundColor(){
        collectionView.backgroundColor = .white
    }

    func registerCollectionView(){
        /*register the collectionView*/
               collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
               /*register the cell*/
               collectionView?.register(UserProfileCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isScrollEnabled = true
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
        return posts.count
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfileCell

        cell.post = posts[indexPath.item]
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

    /*set up for the log out button*/

    fileprivate func setupLogOutButton() {

        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(handleLogOut), imageName: "settings")
        //(image: image, style: .plain, target: self, action: #selector(handleLogOut))
    }

    fileprivate func setupEditButton() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit))

    }

    @objc func handleEdit() {
        print("edit")
    }

    @objc func handleLogOut() {

        print("logging out")
        displayAlert(title: "Log Out", message: "Are you sure?")
    }

    func displayAlert(title: String, message: String) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "LOG OUT", style: .destructive, handler: {(_) in
            print("logged out")
            do {
                try Auth.auth().signOut()
                let loginController = LoginController()
                let navController  = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            } catch let signOutError {
                print("Failed to sign out", signOutError)
            }


        }))
        alertController.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
         self.present(alertController, animated: true, completion: nil)



    }


    /*this function is only accesible in UserProfileViewController*/
    var user: User?
    //MARK: fecth user func
    fileprivate func fecthUser() {
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")

//        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.fetchUserWithUID(uid: uid) { (user) in
                        self.user = user

                        self.navigationItem.title = self.user?.username
                        self.navigationController?.navigationBar.backgroundColor = .white
            //            print(self.user!.profileImageUrl)
                        self.collectionView?.reloadData()
            self.fetchOrderPost()
        }
//        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
//            print(snapshot.value!)
//            guard let dictionary = snapshot.value as? [String:Any] else {return}
////            let userName = dictionary["username"] as? String
//            print(dictionary)
//            self.user = User(uid:uid, dictionary: dictionary)
//
//            self.navigationItem.title = self.user?.username
//            self.navigationController?.navigationBar.backgroundColor = .white
////            print(self.user!.profileImageUrl)
//            self.collectionView?.reloadData()
//
//        }



    }

    fileprivate func fetchOrderPost() {
        guard let uid = self.user?.uid else {return}
         let ref = Database.database().reference().child("posts").child(uid)

        /* perhap later on well implement some pagination of data*/
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            print(snapshot.key, snapshot.value!)
            guard let dictionary = snapshot.value as? [String: Any] else {return}

            guard let user = self.user else {return}

            let post = Post(user: user, dictionary: dictionary)
            self.posts.append(post)
            self.posts.insert(post, at: 0)
//            var paths = [IndexPath]()
//                       let path = IndexPath(row: 0, section: 0)
//                       paths.append(path)


            self.collectionView?.reloadData()
//            self.collectionView?.insertItems(at: paths)

        }) { (err) in
            print("failed to fetch", err)
        }

    }

//    fileprivate func fetchPosts(){
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        let ref = Database.database().reference().child("posts").child(uid)
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            /*access dictionary */
//
//            guard let dictionaries = snapshot.value as? [String: Any] else {return}
////            print("Database snapshot:" ,snapshot.value!)
//
//            dictionaries.forEach({ (key, value) in
//                /*to seperat from each key*/
////                print("Key\(key), Value: \(value)")
//                guard let dictionary = value as? [String:Any] else {return}
////                let imageUrl = dictionary["imageUrl"]as? String
////                print("imageUrl:\(imageUrl)")
//
//                let post = Post(dictionary: dictionary)
//                print(post.imageUrl)
//                self.posts.append(post)
//            })
//            self.collectionView.reloadData()
//
//        })
//
//        { (error) in
//            print("error", error)
//
//        }
//
//
//
//    }


}



