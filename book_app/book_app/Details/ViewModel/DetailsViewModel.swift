//
//  DetailsViewModel.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

class DetailsViewModel: DetailsViewModelInput {
  
  private weak var coordinator: DetailsScreenCoordinatorInput?
  
  private var firebaseRemoteConfigManager: RemoteConfigManager?
  private var imageLoader: ImageLoaderInput?
  
  init(coordinator: DetailsScreenCoordinatorInput,
       firebaseRemoteConfigManager: RemoteConfigManager = FirebaseRemoteConfigManager(),
       imageLoader: ImageLoaderInput = ImageLoader()) {
    self.coordinator = coordinator
    self.firebaseRemoteConfigManager = firebaseRemoteConfigManager
    self.imageLoader = imageLoader
  }
}
