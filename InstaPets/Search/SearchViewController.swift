//
//  SearchViewController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 1/1/20.
//  Copyright © 2020 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    var filteredUsers = [User]()
    var users = [User]()

    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.backgroundColor = .gray
        register()
        searchBarLayout()
//        searchBar.delegate = self
    }

    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.tintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
//        sb.delegate = self
        return sb
    }()

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)

        if searchText.isEmpty{
            filteredUsers = users
        } else {
        filteredUsers = self.users.filter { (user) -> Bool in
            return user.username.lowercased().contains(searchText.lowercased())

            }
        }
        self.collectionView.reloadData()
    }

    func searchBarLayout(){
        collectionView.backgroundColor = .white

//        searchBar.sizeToFit()
//        navigationItem.titleView = searchBar
//        hidesNavigationBarDuringPresentation = false
         navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, right: navBar?.rightAnchor, bottom: navBar?.bottomAnchor, paddlingTop: 8, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 8, width: 0, height: 0)
        collectionView?.alwaysBounceVertical = true
          fetchUser()

    }


    func register(){
        collectionView?.register(CustomSearchCell.self, forCellWithReuseIdentifier: cellId)

         collectionView?.alwaysBounceVertical = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomSearchCell
        
        cell.user = filteredUsers[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: 66)
      }


    fileprivate func fetchUser(){
        print("Fetching User")
        let ref = Database.database().reference().child("users")
              ref.observeSingleEvent(of: .value, with: { (snapshot) in
                  guard let dictionaries = snapshot.value as? [String: Any] else { return }

                  dictionaries.forEach({ (key, value) in
                      guard let userDictionary = value as? [String: Any] else { return }

                      let user = User(uid: key, dictionary: userDictionary)
                      self.users.append(user)
                  })

                  self.users.sort(by: { (u1, u2) -> Bool in

                      return u1.username.compare(u2.username) == .orderedAscending

                  })

                  self.filteredUsers = self.users
                  self.collectionView?.reloadData()

              }) { (err) in
                  print("Failed to fetch users for search:", err)
              }
    }

}
