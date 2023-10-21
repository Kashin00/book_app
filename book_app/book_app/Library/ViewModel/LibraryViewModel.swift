//
//  LibraryViewModel.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation
import UIKit

class LibraryViewModel: LibraryViewModelInput, BannerRepresentableViewControllerDelegate {
  
  private weak var coordinator: LibraryScreenCoordinatorInput?
  
  private var imageLoader: ImageLoaderInput?
  private var dataFetcher: LibraryDataFetcherInput?
  
  var library: Library?
  
  var bannerControllers: [UIViewController] {
    get {
      return getBannerControllers()
    }
  }

  private lazy var bannerControllersStorage: [UIViewController] = []
  
  func getBannerControllers() -> [UIViewController] {
    if bannerControllersStorage.isEmpty {
      bannerControllersStorage = library?.topBannerSlides.compactMap({ banner in
        BannerRepresentableViewController(with: banner, and: self)
      }) ?? []
    }
    
    return bannerControllersStorage
  }
  
  //MARK: Binding
  var bindReloadData: (()->Void)?
  
  init(coordinator: LibraryScreenCoordinatorInput,
       dataFetcher: LibraryDataFetcherInput = LibraryDataFetcher(),
       imageLoader: ImageLoaderInput = ImageLoader()) {
    self.coordinator = coordinator
    self.imageLoader = imageLoader
    self.dataFetcher = dataFetcher
  }
  
  func fetchData() {
    dataFetcher?.fetchLibrary(completion: { [weak self] result in
      switch result {
      case .success(let data):
        self?.library = data
        self?.bindReloadData?()
      case .failure(let error):
        // handle error here
        break
      }
    })
  }
  
  func loadImage(for url: String, competion: @escaping (UIImage) -> ()) {
    //Need to prevent dynamic image caching
    let isDomainWithDynamicImages = url.contains("unsplash.it")
    imageLoader?.loadImage(with: url, with: isDomainWithDynamicImages, competion)
  }
  
  func itemDidSelected(by indexPath: IndexPath) {
    guard let id = library?.bookGenres[indexPath.section].books[indexPath.item].id else { return }
    coordinator?.showDetailsScreen(for: id, with: library?.favouriteItemsID)
  }
  
  func didTapped(with banner: TopBannerSlide) {
    coordinator?.showDetailsScreen(for: banner.bookID, with: library?.favouriteItemsID)
  }
}
