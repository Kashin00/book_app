//
//  SplashScreenViewModel.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

protocol SplashScreenViewModelInput {

}

class SplashScreenViewModel: SplashScreenViewModelInput {
  
  private weak var coordinator: SplashScreenCoordinatorInput?
  
  init(coordinator: SplashScreenCoordinatorInput) {
    self.coordinator = coordinator
  }
}
