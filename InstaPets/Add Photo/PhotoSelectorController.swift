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
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .yellow
        setupNavigationButton()
        collectionViewRegister()
        fetchPhotos()

    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func fecthPhotos() {

        print("fecthing photo")
    }

//MARK:CollectionViewSetup
    func collectionViewRegister() {
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width

        return CGSize(width: width, height: width)
    }
//MARK: the insect for the  section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:  headerId, for: indexPath)
        header.backgroundColor = .red
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
          cell.backgroundColor = .blue
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
    }

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
        print("something")
    }
}
