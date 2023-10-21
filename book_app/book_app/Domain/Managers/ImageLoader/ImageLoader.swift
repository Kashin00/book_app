//
//  ImageLoader.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit
import SDWebImage

protocol ImageLoaderInput {
  func loadImage(with url: String, with options: Bool, _ completion: @escaping (UIImage) -> ())
}

class ImageLoader: ImageLoaderInput {
  
  private var imageViews: [UIImageView] = []
  
  func loadImage(with url: String, with options: Bool, _ completion: @escaping (UIImage) -> ()) {
    guard let url = URL(string: url) else { return }
    let imageView = UIImageView()
    imageViews.append(imageView)
    imageView.sd_setImage(with: url, placeholderImage: nil,
                          options: options ? [.refreshCached, .fromLoaderOnly] : []) { [weak self] image, _, _, _ in
      if let image {
        completion(image)
      }
      self?.imageViews.removeAll(where: { $0 === imageView })
    }
  }
}
