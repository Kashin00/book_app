//
//  LibraryDataFetcher.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

class LibraryDataFetcher: LibraryDataFetcherInput {
  
  private var dataConverter: LibraryDataConverterInput?
  private var remoteConfigManager: RemoteConfigManager?
  
  init(dataConverter: LibraryDataConverterInput? = LibraryDataConverter(),
       remoteConfigManager: RemoteConfigManager = FirebaseRemoteConfigManager()) {
    self.dataConverter = dataConverter
    self.remoteConfigManager = remoteConfigManager
  }
  
  func fetchLibrary(completion: @escaping (Result<Library, Error>) -> ()) {
    remoteConfigManager?.loadData(for: Endpoint.jsonData, { [weak self] result in
      if let convertedResult = self?.dataConverter?.convertToLibrary(result) {
        completion(convertedResult)
      } else {
        completion(.failure(InternalError.fetchingError))
      }
    })
  }
}
