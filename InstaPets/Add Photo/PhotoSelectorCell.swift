//
//  PhotoSelectorCell.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/16/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit


class PhotoSelectorCell: UICollectionViewCell{

    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .gray
        return iv
    } ()

    override init(frame: CGRect) {
        super.init(frame:frame)

        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 0)

//        backgroundColor = .brown

    }


    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




}
