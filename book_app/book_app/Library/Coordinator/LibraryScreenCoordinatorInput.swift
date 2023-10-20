//
//  LibraryScreenCoordinatorInput.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

protocol LibraryScreenCoordinatorInput: Coordinator {
  func showDetailsScreen(with indices: [Int]?)
}
