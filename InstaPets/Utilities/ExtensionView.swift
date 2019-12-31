//
//  ExtensionView.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 11/21/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
 //give an optional value to give something incase you dont have a value for one of this constraint
 func anchor(top: NSLayoutYAxisAnchor?, left:NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, paddlingTop: CGFloat, paddlingLeft: CGFloat, paddlngBottom: CGFloat, paddlingRight: CGFloat, width: CGFloat, height: CGFloat) {

    translatesAutoresizingMaskIntoConstraints = false


     if let top = top {
         self.topAnchor.constraint(equalTo: top, constant: paddlingTop).isActive = true
     }

     if let left = left {
         self.leftAnchor.constraint(equalTo: left, constant: paddlingLeft).isActive = true

     }

     if let bottom = bottom {
         self.bottomAnchor.constraint(equalTo: bottom, constant: -paddlngBottom).isActive = true
     }

     if let right = right {
         self.rightAnchor.constraint(equalTo: right, constant: -paddlingRight).isActive = true
     }

     if width != 0 {
         widthAnchor.constraint(equalToConstant: width).isActive = true
     }

     if height != 0 {
         heightAnchor.constraint(equalToConstant: height).isActive = true
     }




    }
}
