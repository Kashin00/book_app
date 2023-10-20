//
//  LibraryDataConverterInput.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

protocol LibraryDataConverterInput: DataDecoder {
  func convertToLibrary(_ result: Result<Data, Error>) -> Result<Library, Error>
}
