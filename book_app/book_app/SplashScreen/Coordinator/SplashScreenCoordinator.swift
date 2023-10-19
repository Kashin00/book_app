//
//  SplashScreenCoordinator.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

protocol SplashScreenCoordinatorInput: Coordinator {
  
}

class SplashScreenCoordinator: SplashScreenCoordinatorInput {
  var childCoordinators: [Coordinator] = []
  
  var navigationController: UINavigationController
  
  weak var mainCoordinator: MainCoordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewModel = SplashScreenViewModel(coordinator: self)
    let vc = SplashScreenViewController(viewModel: viewModel)
    navigationController.setViewControllers([vc], animated: false)
  }
}
