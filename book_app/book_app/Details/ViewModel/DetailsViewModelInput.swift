//
//  DetailsViewModelInput.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

protocol DetailsViewModelInput {
  var selecteeditemID: Int { get }
  var favoriteItemsIndices: [Int]? { get }
  var books: [Book]? { get }
  
  func fetchData()
  
  //MARK: Bindings
  var bindReloadData: (()->Void)? { get set }
}
