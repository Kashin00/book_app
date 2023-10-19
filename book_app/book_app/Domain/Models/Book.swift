//
//  Book.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

struct Book: Codable, Hashable {
  let id: Int
  let name, author, summary, genre: String
  let coverURL: String
  let views, likes, quotes: String
  
  enum CodingKeys: String, CodingKey {
    case id, name, author, summary, genre
    case coverURL = "cover_url"
    case views, likes, quotes
  }
}
