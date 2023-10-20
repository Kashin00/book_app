//
//  DetailsCorousel.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

struct DetailsCorousel: Decodable {
  let books: [Book]
  
  enum CodingKeys: String, CodingKey {
    case books = "books"
  }
}
