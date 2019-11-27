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

    var user: User? {
        didSet {
            print("did set the username into ",user?.username ?? "")
            setupProfileImage()
            userNameLabel.text = user?.username
        }
    }

//MARK: profileImageVIew setup
    let profileImageView: UIImageView
        = {
            let iv = UIImageView()
            iv.backgroundColor = .gray
            //        iv.image = UserProfileHeader.setupProfileImage(UserProfileHeader)
            return iv
    }()
    //MARK:GRID Button setup
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(named: "grid"), for: .normal)
        return button
    }()

    //MARK: list button setup
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(named:"list"), for: .normal )
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()

    //MARK: RibbonButton setup

    let ribbonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(named:"ribbon"), for: .normal )
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()

    //MARK:UserName label

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    //MARK: post Label
    let postLabel : UILabel = {
        let label = UILabel()
        label.text  = "11\nposts"
        label.numberOfLines = 0
        label.textAlignment = .center

        let attributeText = NSMutableAttributedString(string: "11\n", attributes:[NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributeText


        return label
    }()

    //MARK: Follower label
    let followLabel : UILabel = {
        let label = UILabel()
        let attributeText = NSMutableAttributedString(string: "11\n", attributes:[NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: "follower", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributeText

        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    //MARK: Follwing label
    let followingLabel : UILabel = {
        let label = UILabel()
        let attributeText = NSMutableAttributedString(string: "11\n", attributes:[NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributeText

        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    //MARK: edit Profile Button
    let editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        return button
    }()







    //MARK: profile view uiview setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        //to give a better view
//        backgroundColor = .blue 

        addSubview(profileImageView)
        /*using the extension for this*/
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, right: nil, bottom: nil, paddlingTop: 12, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 0, width: 80, height: 80)
        //make it round 
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        setUpBottomToolBar()

        addSubview(userNameLabel)
        userNameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: gridButton.topAnchor, paddlingTop: 4, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 12, width: 0, height: 0)

        setUpStatsView()

        addSubview(editProfileButton)
        editProfileButton.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, right: followingLabel.rightAnchor, bottom: nil, paddlingTop: 8, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 34)


    }

    //MARK: func setupStatsView

    fileprivate func setUpStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postLabel, followLabel, followingLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)

        stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, bottom: nil, paddlingTop: 12, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 12, width: 0, height: 50)
    }



    //MARK:func Setup bottom Toolbar

     fileprivate func setUpBottomToolBar(){
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray

        let bottomDIviderVIew = UIView()
        bottomDIviderVIew.backgroundColor = UIColor.lightGray

        /*stackView*/
        let stackview = UIStackView(arrangedSubviews: [ gridButton, listButton,ribbonButton])
        addSubview(stackview)
        addSubview(topDividerView)
        addSubview(bottomDIviderVIew)

        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        /*
         left bottom right and the middle
         */
        stackview.anchor(top: nil, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 51)
        /*the thin line on the top of the toolbarview*/
        topDividerView.anchor(top: stackview.topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0.5)
        bottomDIviderVIew.anchor(top: nil, left: leftAnchor, right: rightAnchor, bottom: stackview.bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0.5)

    }


//MARK: func Setup ProfileImage
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
