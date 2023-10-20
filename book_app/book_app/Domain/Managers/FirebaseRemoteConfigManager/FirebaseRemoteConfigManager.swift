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
  
  init() {
    let setting = RemoteConfigSettings()
    setting.minimumFetchInterval = 0
    remoteConfig.configSettings = setting
  }
  
  func loadData(for endpoint: String, _ completion: @escaping (Result<Data, Error>) -> ()) {
    if remoteConfig.lastFetchStatus == .success {
      let fetchedData = remoteConfig[endpoint].dataValue
      completion(.success(fetchedData))
    } else {
      remoteConfig.fetchAndActivate { [weak self] (status, error) in
        guard
          status != .error,
          error == nil,
          let fetchedData = self?.remoteConfig[endpoint].dataValue
        else { completion(.failure(NetworkError.fetchError)); return }
        
        completion(.success(fetchedData))
      }
    }
  }
}
