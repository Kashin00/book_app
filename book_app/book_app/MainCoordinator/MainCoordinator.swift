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
    }
}
