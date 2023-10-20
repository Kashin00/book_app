//
//  DetailsDataFetcherInput.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

protocol DetailsDataFetcherInput {
  func fetchDetailsData(with selectedItemID: Int, completion: @escaping (Result<DetailsCorousel, Error>) -> ())
}
