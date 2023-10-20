//
//  DetailsViewModelInput.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

protocol DetailsViewModelInput {
  var selecteeditemID: Int { get }
  var favoriteBooks: [Book]? { get }
  var books: [Book]? { get }
  
  func fetchData()
  func loadImage(for url: String, competion: @escaping (UIImage) -> ())
  func backButtonDidTap()
  
  //MARK: Bindings
  var bindReloadData: (()->Void)? { get set }
}
