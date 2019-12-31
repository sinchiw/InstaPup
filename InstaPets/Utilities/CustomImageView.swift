//
//  CustomImageViewExtension.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/18/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit

var imageCache = [String: UIImage]()
//var imageC = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView{
    var lastURLUsedToLoadImage: String?

    func loadImage(urlString: String){
        print("Loading image...")
        lastURLUsedToLoadImage = urlString
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
//        if let imageFromCache = imageC.object(forKey: urlString as AnyObject) as? UIImage {
//
//            self.image = imageFromCache
//
//            return
//        }

            guard let url = URL(string:urlString ) else {return}
            URLSession.shared.dataTask(with: url){ (data, response, err) in
                if let error = err{
                    print("Failed to fetch post image", error)
                    return
                }
                    /*evertime the image finish loading it would stop and wont reload again*/
                if url.absoluteString != self.lastURLUsedToLoadImage{return}
                guard let imageData = data else {return}
                let photoImage = UIImage( data: imageData)
                imageCache[url.absoluteString] = photoImage
                DispatchQueue.main.async{
//                    imageC.setObject(imageC, forKey: urlString as AnyObject)
                self.image = photoImage
                }

            }
        .resume()


    }

}
