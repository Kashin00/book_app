//
//  DetailsScreenCoordinator.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

class DetailsScreenCoordinator: DetailsScreenCoordinatorInput {
  var childCoordinators: [Coordinator] = []
  
  var navigationController: UINavigationController
  
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewModel = DetailsViewModel(coordinator: self)
//    let vc = LibraryViewController(viewModel: viewModel)
//    vc.modalPresentationStyle = .fullScreen
//    navigationController.present(vc, animated: true)
  }
}
