//
//  DetailsDataConverterInput.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

protocol DetailsDataConverterInput: DataDecoder {
  func convertToDetailsCarousel(with selectedItemID: Int,
                                _ result: Result<Data, Error>) -> Result<DetailsCorousel, Error>
}
