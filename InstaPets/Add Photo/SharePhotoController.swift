//
//  SharePhotoController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/16/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class SharePhotoController: UIViewController {
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        setUpRightBarButton()
        setupImageAndTextView()
        setupViewBackGroundColor()
    }

    let imageView: UIImageView = {
         let iv = UIImageView()
         iv.backgroundColor = .red
        
         iv.contentMode = .scaleAspectFill
         iv.clipsToBounds = true
         return iv
     }()

    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .blue
//        tv.layer.bounds
        return tv
    }()



    fileprivate func setupImageAndTextView(){
        let containerView = UIView()
        containerView.backgroundColor = .white

        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             bottom: nil,
                             paddlingTop: 0,
                             paddlingLeft: 0,
                             paddlngBottom: 0,
                             paddlingRight: 0,
                             width: 0,
                             height: 100)

        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor,
                         left: containerView.leftAnchor,
                         right: nil,
                         bottom: containerView.bottomAnchor,
                         paddlingTop: 8,
                         paddlingLeft: 8 ,
                         paddlngBottom: 8,
                         paddlingRight: 8,
                         width: 84,
                         height:0)
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor,
                         left: imageView.rightAnchor,
                         right: containerView.rightAnchor,
                         bottom: containerView.bottomAnchor,
                         paddlingTop: 8,
                         paddlingLeft: 2,
                         paddlngBottom: 8,
                         paddlingRight: 2,
                         width: 0, height: 0)

    }

    func setUpRightBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
    }

    func setupViewBackGroundColor(){
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }

    @objc func handleShare() {
        print("sharing photo")

        let filename = NSUUID().uuidString
//         guard let caption = textView.text, !caption.isEmpty else { return }
        guard let image = imageView.image else {return}
        /*or eihter one can be use*/
        guard let selectedImage = selectedImage else {return}
        //march 28 change the image to selected image
        guard let uploadData = selectedImage.jpegData(compressionQuality: 0.5) else {return}

        navigationItem.rightBarButtonItem?.isEnabled = false

        let imageFodler = Storage.storage().reference().child("posts").child(filename)
        imageFodler.putData(uploadData, metadata: nil) { (metaData, error) in
            if error != nil {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Error\(error!.localizedDescription)")

            }

            imageFodler.downloadURL { (url, error) in
                guard let urldownload = url?.absoluteString else {return}
                print(urldownload)
                print("image succesfully uploaded to firebase storage")
                self.saveToDataBaseWithImageUrl(imageUrl: urldownload)
                self.dismiss(animated: true, completion: nil)
            }




        }
    }


    fileprivate func saveToDataBaseWithImageUrl(imageUrl: String){
        guard let caption = textView.text else {return}
        guard let postImage = selectedImage else {return}
        guard let userUid = Auth.auth().currentUser?.uid else {return}
        let userPostRef = Database.database().reference().child("posts").child(userUid)
        let ref = userPostRef.childByAutoId()
        let values = ["imageUrl": imageUrl, "caption":caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String: Any]
        ref.updateChildValues(values){ (error, reference) in
            if  error != nil {
                print("unsuccess, \(error!.localizedDescription)")

            }
            print("Succesfully saved post to db")

        }

    }


}
