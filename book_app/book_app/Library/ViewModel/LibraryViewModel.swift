//
//  LibraryViewModel.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation
import UIKit

class LibraryViewModel: LibraryViewModelInput {
  
  private weak var coordinator: LibraryScreenCoordinatorInput?
  
  private var firebaseRemoteConfigManager: RemoteConfigManager?
  private var imageLoader: ImageLoaderInput?
  
  var library: Library?
  
  var bannerControllers: [UIViewController] {
    get {
      return bannerControllersStorage
    }
  }

  private lazy var bannerControllersStorage = library?.topBannerSlides.compactMap({ banner in
    BannerRepresentableViewController(banner: banner)
  }) ?? []
  
  //MARK: Binding
  var bindReloadData: (()->Void) = {}
  
  init(coordinator: LibraryScreenCoordinatorInput,
       firebaseRemoteConfigManager: RemoteConfigManager = FirebaseRemoteConfigManager(),
       imageLoader: ImageLoaderInput = ImageLoader()) {
    self.coordinator = coordinator
    self.firebaseRemoteConfigManager = firebaseRemoteConfigManager
    self.imageLoader = imageLoader
  }
  
  func fetchData() {
    firebaseRemoteConfigManager?.fetchLibrary({ [weak self] result in
      switch result {
      case .success(let data):
        self?.library = data
        self?.bindReloadData()
      case .failure(let error):
        break
      }
    })
  }
  
  func loadImage(for url: String, competion: @escaping (Data) -> ()) {
    imageLoader?.loadImage(with: url, competion)
  }
}
