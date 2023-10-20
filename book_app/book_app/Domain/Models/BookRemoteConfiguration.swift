//
//  BookRemoteConfiguration.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

struct BookRemoteConfiguration: Codable {
  let books: [Book]
  let topBannerSlides: [TopBannerSlide]
  let favouriteItemsID: [Int]
  
  enum CodingKeys: String, CodingKey {
    case books
    case topBannerSlides = "top_banner_slides"
    case favouriteItemsID = "you_will_like_section"
  }
}
