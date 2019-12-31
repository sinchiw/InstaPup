//
//  UserProfileCell.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/17/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit

class UserProfileCell: UICollectionViewCell{
    var post: Post? {
        didSet {

            guard let imageUrl = post?.imageUrl else {return}
            photoImageView.loadImage(urlString: imageUrl)
            print(post?.imageUrl)
        }
    }

    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .gray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    override init(frame:CGRect){
        super.init(frame:frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0)

    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
