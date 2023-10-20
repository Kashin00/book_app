//
//  UICollectionViewCell.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

extension UICollectionViewCell {
  func transformToLarge(with duration: TimeInterval, scaleX: CGFloat, scaleY: CGFloat) {
    UIView.animate(withDuration: duration) {
      self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
  }
  
  func transformToStandard(with duration: TimeInterval) {
    UIView.animate(withDuration: duration) {
      self.transform = CGAffineTransform.identity
    }
  }
}
