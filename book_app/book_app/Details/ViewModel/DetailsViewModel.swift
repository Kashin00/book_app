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
  
  var selecteeditemID: Int
  var favoriteItemsIndices: [Int]?
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
        break
      case .failure(let error):
        break
      }
    })
  }
}
