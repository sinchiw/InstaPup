//
//  HomePostCell.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/26/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit

class HomePostCell: UICollectionViewCell {


    var post: Post?{
        didSet{
//            print(post?.imageUrl)
            guard let postImageUrl = post?.imageUrl else {return}
            photoImageView.loadImage(urlString: postImageUrl)
            userNameLabel.text = post?.user.username

            guard let profileImageUrl = post?.user.profileImageUrl else {return}
            userProfileImageView.loadImage(urlString: profileImageUrl)
            captionLabel.text = post?.caption
            setupAttributedCaption()
        }
    }



    let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .gray
        return iv
    }()

    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    let optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let likeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(named: "like_unselected")!.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    let commentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(named: "comment")!.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    let captionLabel: UILabel = {
        let label = UILabel()


        label.numberOfLines = 0

        return label
    }()

    let cellId = "cellId"

    override init(frame: CGRect){
        super.init(frame:frame)
        /*order of subview doesnt matter as long you have subview before the anchor or constraint*/
        addSubview(userProfileImageView)
        addSubview(photoImageView)
        addSubview(userNameLabel)
        addSubview(optionButton)
//        addSubview(likeButton)
//        addSubview(commentButton)
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, right: nil, bottom: nil, paddlingTop: 8, paddlingLeft: 8, paddlngBottom: 0, paddlingRight: 0, width: 40, height: 40)
        userProfileImageView.layer.cornerRadius = 40/2

        userNameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, right: optionButton.leftAnchor, bottom: photoImageView.topAnchor, paddlingTop: 0, paddlingLeft: 8, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0)

        optionButton.anchor(top: topAnchor, left: nil, right: rightAnchor, bottom: photoImageView.topAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 8, width: 44, height: 0)

        photoImageView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddlingTop: 8, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        setupActionButton()
        addSubview(captionLabel)
        captionLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddlingTop: 0, paddlingLeft: 7, paddlngBottom: 0, paddlingRight: 7, width: 0, height: 0)
    }

    fileprivate func setupActionButton() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: photoImageView.bottomAnchor, left: nil, right: rightAnchor, bottom: nil, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 8, width: 120, height: 50)
    }

    fileprivate func setupAttributedCaption() {
        guard let post = self.post else {return}

        let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14)]))
            attributedText.append(NSAttributedString(string: " \n\n", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 4)]))

            attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        captionLabel.attributedText = attributedText

    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
