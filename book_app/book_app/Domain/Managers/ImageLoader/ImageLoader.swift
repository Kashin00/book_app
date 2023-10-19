//
//  ImageLoader.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

protocol ImageLoaderInput {
  func loadImage(with url: String, _ completion: @escaping (Data) -> ())
}

class ImageLoader: ImageLoaderInput {
  func loadImage(with url: String, _ completion: @escaping (Data) -> ()) {
    guard let url = URL(string: url) else { return }
    URLSession.shared.dataTask(with: url) { data, reponse, error in
      guard let data = data else { return }
      completion(data)
    }.resume()
  }  
}
