//
//  PhotoSelectorController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/13/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

    let cellId = "cellID"
    let headerId = "headerID"
    /*array of images*/
    var images = [UIImage]()
    var selectedImages: UIImage?
    var assets = [PHAsset]()
    var header: PhotoSelectorHeader?


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white
        setupNavigationButton()
        collectionViewRegister()
        fectchPhotos()

    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    fileprivate func assetsFetchOption()-> PHFetchOptions{
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions

    }



    fileprivate func fectchPhotos() {
//        print("fecthing photo")
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.fetchLimit = 10
//
//        let sortDescriptor = NSSortDescriptor(key: "creationData", ascending: false)
//        //        fetchOptions.sortDescriptors = [sortDescriptor]
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOption())
        allPhotos.enumerateObjects { (assets, count, stop) in
            print(assets)
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 200, height: 200)
            print(count)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: assets, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                print(image!)
                if let image = image{
                    self.images.append(image)
                    self.assets.append(assets)
                    //MARK: can add image here if you want
                    if self.selectedImages == nil {
                        self.selectedImages = image

                    }
                }
                if (count == allPhotos.count - 1) {
                    DispatchQueue.main.async {
                         self.collectionView?.reloadData()
                    }

                }
                //                self.collectionView?.reloadData()
            }
        }
    }

//MARK:CollectionViewSetup
    func collectionViewRegister() {
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:  headerId, for: indexPath) as! PhotoSelectorHeader
        self.header = header
        header.photoImageView.image = selectedImages

        if let seletedImages = selectedImages {
            if let index = self.images.firstIndex(of: seletedImages){
                let selectAsset = self.assets[index]
                 let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 600, height: 600)
                imageManager.requestImage(for: selectAsset, targetSize: targetSize, contentMode: .default, options: nil) { (image, info) in
                    header.photoImageView.image = image 
                }
            }


        }




        return header
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width

        return CGSize(width: width, height: width)
    }
//MARK: the insect for the  section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
//          cell.backgroundColor = .blue
        cell.photoImageView.image = images[indexPath.item]
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-3)/4
        return CGSize(width: width, height: width)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        self.selectedImages = images[indexPath.item]
        collectionView.reloadData()
        let indexPath = IndexPath(item: 0, section:0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }





//MARK:selecting photo setup

    fileprivate func setupNavigationButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain
                                                         ,target: self
                                                         ,action: #selector(handleCancel))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
                                                               style: .plain
                                                             ,target: self
                                                             ,action: #selector(handleNext))
    }

    @objc func handleNext(){
        print("working")
        let sharePhotoController = SharePhotoController()
        sharePhotoController.selectedImage = header?.photoImageView.image
        navigationController?.pushViewController(sharePhotoController, animated: true)
    }

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
        print("something")
    }
}
