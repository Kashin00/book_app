//
//  RemoteConfigDataMapper.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

protocol RemoteConfigDataMapperInput: AnyObject {
  func mapBooksByGenre(_ books: [Book]) -> [BookGenre]
}

class RemoteConfigDataMapper: RemoteConfigDataMapperInput {
  func mapBooksByGenre(_ books: [Book]) -> [BookGenre] {
    Dictionary(grouping: books, by: { $0.genre })
      .map { BookGenre(genre: $0.key, books: $0.value) }
  }
}
