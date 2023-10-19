//
//  LibraryScreenCoordinator.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class LibraryScreenCoordinator: LibraryScreenCoordinatorInput {
  var childCoordinators: [Coordinator] = []
  
  var navigationController: UINavigationController
  
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewModel = LibraryViewModel(coordinator: self)
    let vc = LibraryViewController(viewModel: viewModel)
    vc.modalPresentationStyle = .fullScreen
    navigationController.present(vc, animated: true)
  }
}
