//
//  LibraryViewModelInput.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation
import UIKit

protocol LibraryViewModelInput {
  
  var library: Library? { get }
  var bannerControllers: [UIViewController] { get }
  
  func fetchData()
  func loadImage(for url: String, competion: @escaping (Data) -> ())
  func itemDidSelected(by indexPath: IndexPath)
  
  //MARK: Bindings
  var bindReloadData: (()->Void) { get set }
}
