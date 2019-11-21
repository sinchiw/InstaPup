//
//  UserProfileHeader.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 11/20/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import FirebaseCore

class UserProfileHeader: UICollectionViewCell {

    let profileImageView: UIImageView
        = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
//        iv.image = UserProfileHeader.setupProfileImage(UserProfileHeader)
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //to give a better view
        backgroundColor = .blue

        addSubview(profileImageView)
        /*using the extension for this*/
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, right: nil, bottom: nil, paddlingTop: 12, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 0, width: 80, height: 80)
        //make it round 
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
    }


    var user: User? {
        didSet {
            print("did set the username",user?.username ?? "")
            setupProfileImage()
        }
    }

    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImageUrl else { return }
//        guard let profileImageurl = User.user
        print("url into data",profileImageUrl)

        guard let url = URL(string: profileImageUrl) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for the error, then construct the image using data
            if let err = err {
                print("Failed to fetch profile image:", err)
                return
            }

            //perhaps check for response status of 200 (HTTP OK)

            guard let data = data else { return }

            let image = UIImage(data: data)


            //need to get back onto the main UI thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }

            }.resume()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
