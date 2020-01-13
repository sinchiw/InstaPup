//
//  MainTabBarController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 11/19/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

//import Foundation
import UIKit
import FirebaseAuth


class MainTabBarController : UITabBarController, UITabBarControllerDelegate {


    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //little trick to do when you select the tabbar button
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelector = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelector)
//            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            return false
        }

        print(index!)
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
         check if the user isnt log in 
         */
        self.delegate = self
//        navigationController?.navigationBar.backgroundColor = .white
        if Auth.auth().currentUser == nil {

            //show if not logg in
            DispatchQueue.main.async{
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                
                self.present(navController, animated: true, completion: nil)
            }
            return
        }

        setUpViewController()


        
    }

    func setUpViewController(){
        view.backgroundColor = .white

        //MARK: home controller

        let homeNaVController = templateNavController(uselectedImage: UIImage(named:"home_selected")!, selectedImage: UIImage(named:"home_unselected")!,rootViewController: HomeViewController(collectionViewLayout: UICollectionViewFlowLayout()))

        //MARK: User Profile
        //flowlout, collection view in horizontal or vertical
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        //        let controller = [userProfileController]
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        userProfileNavController.tabBarItem.image = UIImage(named: "user-3")
        userProfileNavController.tabBarItem.selectedImage = UIImage(named: "user")
        /*to chance the tab bar color*/


        //MARK: search controller
        let searchNavController = templateNavController(uselectedImage: UIImage(named: "search_selected")!, selectedImage:  UIImage(named: "search_unselected")!, rootViewController: SearchViewController(collectionViewLayout: UICollectionViewFlowLayout()))


        //MARK: add Photo Controller

        let  addNaVController = templateNavController(uselectedImage: UIImage(named:"plus_unselected")!, selectedImage: UIImage(named: "plus_unselected")!)
//        tabBar.tintColor = .black

        viewControllers = [homeNaVController,
                           searchNavController,
                           addNaVController,
                           userProfileNavController]

        //customize the tab bar insets to the middle
        guard let items = tabBar.items else {return}
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }

    }
    /*condensing the code*/
    fileprivate func templateNavController(uselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController{
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = uselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.backgroundColor = .white
        return navController

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let vcs = viewControllers {
            for (_,vc) in vcs.enumerated() {
                vc.view.removeFromSuperview()
            }
        }
    }

}
