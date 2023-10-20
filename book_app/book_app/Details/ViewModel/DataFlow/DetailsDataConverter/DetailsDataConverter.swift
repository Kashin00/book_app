//
//  DetailsDataConverter.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

class DetailsDataConverter: DetailsDataConverterInput {
  func convertToDetailsCarousel(with selectedItemID: Int,
                                _ result: Result<Data, Error>) -> Result<DetailsCorousel, Error> {
    switch result {
    case .success(let fetchedData):
      do {
        var decodedData: DetailsCorousel = try dataDecoder(fetchedData)
        decodedData.tryMove(selectedItemID, to: 0)
        return .success(decodedData)
      } catch {
        return .failure(InternalError.decodingError)
      }
    case .failure(let error):
      return .failure(error)
    }
  }
}
