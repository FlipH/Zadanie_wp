//
//  ImageCache.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

protocol ImageCacheProtocol {
    func getObject(with key: String) -> UIImage?
    func setObject(object: UIImage, for key: String)
}

class ImageCache: ImageCacheProtocol {
    private let imageCache = NSCache<NSString, AnyObject>()

    func getObject(with key: String) -> UIImage? {
        if let cachedImage = imageCache.object(forKey: key as NSString) as? UIImage {
            return cachedImage
        } else {
            return nil
        }
    }

    func setObject(object: UIImage, for key: String) {
        imageCache.setObject(object, forKey: key as NSString)
    }
}



