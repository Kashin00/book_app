//
//  LibraryDataFetcherInput.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

protocol LibraryDataFetcherInput {
  func fetchLibrary(completion: @escaping (Result<Library, Error>) -> ())
}
