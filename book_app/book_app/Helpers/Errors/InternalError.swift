//
//  InternalError.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

enum InternalError: Error {
  case decodingError
  case mappingError
  case fetchingError
}
