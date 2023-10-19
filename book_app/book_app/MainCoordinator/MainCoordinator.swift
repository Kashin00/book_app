//
//  MainCoordinator.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class MainCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController = UINavigationController()
  
  func start() {
    let splashScreenCoordinator = SplashScreenCoordinator(navigationController: navigationController)
    childCoordinators.append(splashScreenCoordinator)
    splashScreenCoordinator.start()
    splashScreenCoordinator.finishFlowHandler = { [weak self] in
      self?.childCoordinators.removeAll(where: { $0 is SplashScreenCoordinator })
      self?.startLibraryFlow()
      if let index = self?.navigationController.viewControllers.firstIndex(where: { $0 is SplashScreenViewController }) {
        self?.navigationController.viewControllers.remove(at: index)
      }
    }
  }
  
  func startLibraryFlow() {
    let liblaryScreenCoordinator = LibraryScreenCoordinator(navigationController: navigationController)
    childCoordinators.append(liblaryScreenCoordinator)
    liblaryScreenCoordinator.start()
  }
}
