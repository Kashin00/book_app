//
//  DetailsDataFetcher.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

class DetailsDataFetcher: DetailsDataFetcherInput {
  
  private var dataConverter: DetailsDataConverterInput?
  private var remoteConfigManager: RemoteConfigManager?
  
  init(dataConverter: DetailsDataConverterInput? = DetailsDataConverter(),
       remoteConfigManager: RemoteConfigManager = FirebaseRemoteConfigManager()) {
    self.dataConverter = dataConverter
    self.remoteConfigManager = remoteConfigManager
  }
  
  func fetchDetailsData(completion: @escaping (Result<DetailsCorousel, Error>) -> ()) {
    remoteConfigManager?.loadData(for: Endpoint.details, { [weak self] result in
      if let convertedResult = self?.dataConverter?.convertToDetailsCarousel(result) {
        completion(convertedResult)
      } else {
        completion(.failure(InternalError.fetchingError))
      }
    })
  }
}
