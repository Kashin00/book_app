//
//  DetailsCorousel.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

struct DetailsCorousel: Decodable {
  
  private(set) var books: [Book]
  
  mutating func tryMove(_ selectedBookID: Int, to newIndex: Int) {
    guard let bookIndex = books.firstIndex(where: { $0.id == selectedBookID }) else { return }
    let selectedBook = books.remove(at: bookIndex)
    books.insert(selectedBook, at: newIndex)
  }
  
  enum CodingKeys: String, CodingKey {
    case books = "books"
  }
}
