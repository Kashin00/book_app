//
//  DetailsDataConverter.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

class DetailsDataConverter: DetailsDataConverterInput {
  func convertToDetailsCarousel(_ result: Result<Data, Error>) -> Result<DetailsCorousel, Error> {
    switch result {
    case .success(let fetchedData):
      do {
        let decodedData: DetailsCorousel = try dataDecoder(fetchedData)
        return .success(decodedData)
      } catch {
        return .failure(InternalError.decodingError)
      }
    case .failure(let error):
      return .failure(error)
    }
  }
}
