//
//  LibraryDataConverter.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

class LibraryDataConverter: LibraryDataConverterInput {
  
  private var dataMapper: RemoteConfigDataMapperInput?
  
  init(dataMapper: RemoteConfigDataMapperInput? = RemoteConfigDataMapper()) {
    self.dataMapper = dataMapper
  }
  
  func convertToLibrary(_ result: Result<Data, Error>) -> Result<Library, Error> {
    switch result {
    case .success(let fetchedData):
      do {
        let decodedData = try JSONDecoder().decode(BookRemoteConfiguration.self, from: fetchedData)
        if let booksByGenre = dataMapper?.mapBooksByGenre(decodedData.books) {
          let library = Library(bookGenres: booksByGenre, topBannerSlides: decodedData.topBannerSlides, favouriteItemsID: decodedData.favouriteItemsID)
          return .success(library)
        } else {
          return .failure(InternalError.mappingError)
        }
      } catch {
        return .failure(InternalError.decodingError)
      }
    case .failure(let error):
      return .failure(error)
    }
  }
}
