//
//  CustomSeachCellController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 1/6/20.
//  Copyright © 2020 Wilmer sinchi. All rights reserved.
//


import UIKit

class CustomSearchCell: UICollectionViewCell {
    var user: User? {
        didSet {
            userNameLabel.text = user?.username

            guard let profileImageUrl = user?.profileImageUrl else {
                return}
            profileImageView.loadImage(urlString: profileImageUrl)
        }
    }


    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    let userNameLabel: UILabel = {
           let label = UILabel()
           label.text = "UserName"
           label.font = UIFont.boldSystemFont(ofSize: 14)

           return label
       }()



    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .white
        

              addSubview(profileImageView)
              addSubview(userNameLabel)

              profileImageView.anchor(top: nil, left: leftAnchor, right: nil, bottom: nil, paddlingTop: 0, paddlingLeft: 5, paddlngBottom: 0, paddlingRight: 0, width: 50, height: 50)
              profileImageView.layer.cornerRadius = 50/2
              profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

              userNameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, bottom: bottomAnchor, paddlingTop: 0, paddlingLeft: 8, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0)

              let seperatorView = UIView()
              seperatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
              addSubview(seperatorView)
              seperatorView.anchor(top: nil, left: userNameLabel.leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0.5)

    }





    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }


}
