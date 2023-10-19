//
//  FirebaseRemoteConfigManager.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation
import FirebaseRemoteConfig

class FirebaseRemoteConfigManager: RemoteConfigManager {
  
  private let remoteConfig = RemoteConfig.remoteConfig()
  private var dataMapper: RemoteConfigDataMapperInput?
  
  init(dataMapper: RemoteConfigDataMapperInput? = RemoteConfigDataMapper()) {
    let setting = RemoteConfigSettings()
    setting.minimumFetchInterval = 0
    remoteConfig.configSettings = setting
    self.dataMapper = dataMapper
  }
  
  func fetchLibrary(_ completion: @escaping (Result<Library, Error>) -> ()) {
    remoteConfig.fetchAndActivate { [weak self] (status, error) in
      
      guard
        status != .error,
        error == nil,
        let fetchedData = self?.remoteConfig["json_data"].dataValue
      else { completion(.failure(NetworkError.fetchError)); return }
      
      do {
        let decodedData = try JSONDecoder().decode(BookRemoteConfiguration.self, from: fetchedData)
        if let booksByGenre = self?.dataMapper?.mapBooksByGenre(decodedData.books) {
          let library = Library(bookGenres: booksByGenre, topBannerSlides: decodedData.topBannerSlides, youWillLikeSection: decodedData.youWillLikeSection)
          completion(.success(library))
        } else {
          completion(.failure(InternalError.mappingError))
        }
      } catch {
        completion(.failure(InternalError.decodingError))
      }
    }
  }
}









