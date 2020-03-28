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
//            print("did set the username into ",user?.username ?? "")
            guard let profileImageUrl = user?.profileImageUrl else {return}
            profileImageView.loadImage(urlString: profileImageUrl)
            
            userNameLabel.text = user?.username


            setupEditFollowButton()
        }
    }

//MARK: profileImageVIew setup
    let profileImageView: CustomImageView
        = {
            let iv = CustomImageView()
            iv.backgroundColor = .gray


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

        let attributeText = NSMutableAttributedString(string: "0\n", attributes:[NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributeText


        return label
    }()

    //MARK: Follower label
    let followLabel : UILabel = {
        let label = UILabel()
        let attributeText = NSMutableAttributedString(string: "0\n", attributes:[NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: "follower", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributeText

        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    //MARK: Follwing label
    let followingLabel : UILabel = {
        let label = UILabel()
        let attributeText = NSMutableAttributedString(string: "0\n", attributes:[NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributeText

        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    let statView : UIStackView = {
        let statview = UIStackView()
        statview.distribution = .fillEqually
        return statview
    }()





    //MARK: edit Profile Button
    lazy var editFollowButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleEditProfileOrFollow), for: .touchUpInside)

        return button
    }()







    //MARK: profile view uiview setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        //to give a better view


        addSubview(profileImageView)
        addSubview(statView)
        addSubview(editFollowButton)
        /*using the extension for this*/

        profileImageView.layer.cornerRadius = 150 / 2
        profileImageView.clipsToBounds = true
        profileImageView.anchor(top: topAnchor, left: nil, right: nil, bottom: nil, paddlingTop: 5, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 150, height: 200)

        profileImageView.centerXAnchor.constraint(equalTo: statView.centerXAnchor, constant: 0).isActive = true
        //make it round
        statView.addArrangedSubview(postLabel)
        statView.addArrangedSubview(followLabel)
        statView.addArrangedSubview(followingLabel)

        statView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddlingTop: 10, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 12, width: 0, height: 50)
        editFollowButton.anchor(top: statView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddlingTop: 10, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 12, width: 0, height: 30)
//        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

//        let stackView = UIStackView(arrangedSubviews: [postLabel, followLabel, followingLabel])
//        stackView.distribution = .fillEqually
//        addSubview(stackView)
//
//        stackView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddlingTop: 10, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 12, width: 0, height: 50)
//*/










        let topDividerView = UIView()
              topDividerView.backgroundColor = UIColor.lightGray

              let bottomDIviderVIew = UIView()
              bottomDIviderVIew.backgroundColor = UIColor.lightGray

              /*stackView*/
              let stackview2 = UIStackView(arrangedSubviews: [ gridButton, listButton,ribbonButton])
              addSubview(stackview2)
              addSubview(topDividerView)
              addSubview(bottomDIviderVIew)

              stackview2.axis = .horizontal
              stackview2.distribution = .fillEqually
              /*
               left bottom right and the middle
               */
            stackview2.anchor(top: editFollowButton.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddlingTop: 10, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 51)
              /*the thin line on the top of the toolbarview*/
              topDividerView.anchor(top: stackview2.topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0.5)
              bottomDIviderVIew.anchor(top: nil, left: leftAnchor, right: rightAnchor, bottom: stackview2.bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0.5)










//
//        setUpBottomToolBar()
//
//        addSubview(userNameLabel)
//        userNameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: gridButton.topAnchor, paddlingTop: 4, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 12, width: 0, height: 0)
//
//        setUpStatsView()
//
//        addSubview(editProfileButton)
//        editProfileButton.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, right: followingLabel.rightAnchor, bottom: nil, paddlingTop: 8, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 34)
//

    }

    //MARK: func setupStatsView

    fileprivate func setUpStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postLabel, followLabel, followingLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)

        stackView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddlingTop: 10, paddlingLeft: 12, paddlngBottom: 0, paddlingRight: 12, width: 0, height: 50)
    }




//    //MARK:func Setup bottom Toolbar
//
//     fileprivate func setUpBottomToolBar(){
//        let topDividerView = UIView()
//        topDividerView.backgroundColor = UIColor.lightGray
//
//        let bottomDIviderVIew = UIView()
//        bottomDIviderVIew.backgroundColor = UIColor.lightGray
//
//        /*stackView*/
//        let stackview = UIStackView(arrangedSubviews: [ gridButton, listButton,ribbonButton])
//        addSubview(stackview)
//        addSubview(topDividerView)
//        addSubview(bottomDIviderVIew)
//
//        stackview.axis = .horizontal
//        stackview.distribution = .fillEqually
//        /*
//         left bottom right and the middle
//         */
//        stackview.anchor(top: nil, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 51)
//        /*the thin line on the top of the toolbarview*/
//        topDividerView.anchor(top: stackview.topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0.5)
//        bottomDIviderVIew.anchor(top: nil, left: leftAnchor, right: rightAnchor, bottom: stackview.bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0.5)
//
//    }
//MARK: set up editButton
    fileprivate func setupEditFollowButton(){
        guard let currenUserId = Auth.auth().currentUser?.uid else {return}
        guard let userId = user?.uid else {return}

        if currenUserId == userId {
//            editFollowButton.setTitle("Edit", for: .normal)
        } else {
            //check if following

            Database.database().reference().child("following").child(currenUserId).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                //print out what it is in the database
                if let isFollowing = snapshot.value as? Int, isFollowing == 1 {
                    self.editFollowButton.setTitle("Unfollow", for: .normal)

                } else  {
                    self.setUpFollowStyle()

                }




//                print(snapshot.value)
            },withCancel: {(err) in
                print("Failed to check if follwing", err)
            })


        }

    }

    //MARK: set up the followButton actions
    @objc  func handleEditProfileOrFollow(){
        print("Execute edit/profile/follow unfollow logic...")
        guard let currentLoggedInId = Auth.auth().currentUser?.uid else {return}
        guard let userId = user?.uid else {return}

        //handle the unfollow logic
        if editFollowButton.titleLabel?.text == "Unfollow" {

            Database.database().reference().child("following").child(currentLoggedInId).child(userId).removeValue(completionBlock: { (err, ref) in
                if let err = err {
                    print("Failed to unfollow user:", err)
                    return

                }
                print("Succesfully unfollowed user:", self.user?.username ?? "")
                self.setUpFollowStyle()

            })
        }else  {
            //follow logic
            let ref = Database.database().reference().child("following").child(currentLoggedInId)
            //dictionary
            let values = [userId: 1]
            ref.updateChildValues(values) { (err, ref) in
                if let err = err{
                    print("Failed to follow users:", err)
                }
                print("Succesfull followed user:", self.user?.username ?? "")
                self.editFollowButton.setTitle("Unfollow", for: .normal)

                self.editFollowButton.backgroundColor = .white
                self.editFollowButton.setTitleColor(.black, for: .normal)
            }

        }




    }

    fileprivate func setUpFollowStyle(){
        self.editFollowButton.setTitle("Follow", for: .normal)
                                       self.editFollowButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
                                       self.editFollowButton.setTitleColor(.white, for: .normal)
                                       self.editFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
