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
  
  private var itemID: Int
  private var favoriteItemIndices: [Int]?
  
  init(navigationController: UINavigationController, for itemID: Int, with favoriteItemIndices: [Int]?) {
    self.navigationController = navigationController
    self.itemID = itemID
    self.favoriteItemIndices = favoriteItemIndices
  }
  
  func start() {
    let viewModel = DetailsViewModel(itemID: itemID, favoriteItemIndices: favoriteItemIndices, coordinator: self)
    let vc = DetailsViewController(viewModel: viewModel)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func close() {
    navigationController.popViewController(animated: true)
  }
}
