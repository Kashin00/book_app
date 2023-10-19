//
//  LibraryViewModel.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

class LibraryViewModel: LibraryViewModelInput {
  
  private weak var coordinator: LibraryScreenCoordinatorInput?
  
  private var firebaseRemoteConfigManager: RemoteConfigManager?
  
  private var library: Library?
  
  
  init(coordinator: LibraryScreenCoordinatorInput,
       firebaseRemoteConfigManager: RemoteConfigManager = FirebaseRemoteConfigManager()) {
    self.coordinator = coordinator
    self.firebaseRemoteConfigManager = firebaseRemoteConfigManager
  }
  
  func fetchData() {
    firebaseRemoteConfigManager?.fetchLibrary({ [weak self] result in
      switch result {
      case .success(let data):
        self?.library = data
      case .failure(let error):
        break
      }
    })
  }
}
