//
//  DetailsViewModelInput.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

protocol DetailsViewModelInput {
  var selecteeditemID: Int { get }
  var favoriteBooks: [Book]? { get }
  var books: [Book]? { get }
  
  func fetchData()
  func loadImage(for url: String, competion: @escaping (Data) -> ())

  //MARK: Bindings
  var bindReloadData: (()->Void)? { get set }
}
