//
//  MainTabBarController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 11/19/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

//import Foundation
import UIKit

class MainTabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        //flowlout, collection view in horizontal or vertical
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)

//        let controller = [userProfileController]
        let navCon = UINavigationController(rootViewController: userProfileController)

        navCon.tabBarItem.image = UIImage(named: "user-3")
        navCon.tabBarItem.selectedImage = UIImage(named: "user")

//        tabBar.tintColor = .black
        viewControllers = [navCon, UIViewController()]

        
    }


}
