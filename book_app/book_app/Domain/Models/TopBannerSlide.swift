//
//  TopBannerSlide.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

struct TopBannerSlide: Codable {
  let id, bookID: Int
  let cover: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case bookID = "book_id"
    case cover
  }
}
