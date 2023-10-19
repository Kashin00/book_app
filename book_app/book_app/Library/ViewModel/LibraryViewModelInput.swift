//
//  LibraryViewModelInput.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

protocol LibraryViewModelInput {
  var library: Library? { get }
  
  func fetchData()
  func loadImage(for url: String, competion: @escaping (Data) -> ())
  //MARK: Bindings
  var bindReloadData: (()->Void) { get set }
}
