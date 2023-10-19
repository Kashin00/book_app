//
//  LibraryViewModel.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

class LibraryViewModel: LibraryViewModelInput {
  
  private weak var coordinator: LibraryScreenCoordinatorInput?
  
  init(coordinator: LibraryScreenCoordinatorInput) {
    self.coordinator = coordinator
  }
}
