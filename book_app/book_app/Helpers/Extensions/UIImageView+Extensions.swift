//
//  UIImageView+Extensions.swift
//  book_app
//
//  Created by Матвей Кашин on 21.10.2023.
//

import UIKit

extension UIImageView {
  func setImageAnimatableIfNeede(with image: UIImage?) {
    if self.image == nil {
      UIView.transition(with: self,
                        duration: 0.75,
                        options: .transitionCrossDissolve,
                        animations: { self.image = image },
                        completion: nil)
    } else {
      self.image = image
    }
  }
}
