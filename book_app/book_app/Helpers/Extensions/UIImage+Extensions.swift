//
//  UIImage+Extensions.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

extension UIImage {
  func mergeWith(topImage: UIImage) -> UIImage {
    let bottomImage = self

    UIGraphicsBeginImageContext(size)

    let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
    bottomImage.draw(in: areaSize)

    topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)

    let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return mergedImage
  }
}
