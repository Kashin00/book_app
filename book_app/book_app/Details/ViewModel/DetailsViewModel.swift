//
//  DetailsViewModel.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

class DetailsViewModel: DetailsViewModelInput {
  
  private weak var coordinator: DetailsScreenCoordinatorInput?
  
  private var imageLoader: ImageLoaderInput?
  private var dataFetcher: DetailsDataFetcherInput?
  
  private var favoriteItemsIndices: [Int]?
  
  var selecteeditemID: Int
  var favoriteBooks: [Book]?
  var books: [Book]?

  var bindReloadData: (() -> Void)?
  
  init(itemID: Int,
       favoriteItemIndices: [Int]?,
       coordinator: DetailsScreenCoordinatorInput,
       imageLoader: ImageLoaderInput = ImageLoader(),
       dataFetcher: DetailsDataFetcherInput = DetailsDataFetcher()) {
    self.coordinator = coordinator
    self.imageLoader = imageLoader
    self.selecteeditemID = itemID
    self.favoriteItemsIndices = favoriteItemIndices
    self.dataFetcher = dataFetcher
  }
  
  
  func fetchData() {
    dataFetcher?.fetchDetailsData(with: selecteeditemID, completion: { [weak self] result in
      switch result {
      case .success(let data):
        self?.books = data.books
        
        self?.favoriteBooks = data.books.compactMap({ book in
          if self?.favoriteItemsIndices?.contains(book.id) == true {
            return book
          } else {
            return nil
          }
        })
        
        self?.bindReloadData?()
      case .failure(let error):
        break
      }
    })
  }
  
  func loadImage(for url: String, competion: @escaping (UIImage) -> ()) {
    imageLoader?.loadImage(with: url, with: false, competion)
  }
  
  func backButtonDidTap() {
    coordinator?.close()
  }
}
