//
//  RemoteConfigManager.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation

protocol RemoteConfigManager {
  func loadData(for endpoint: String, _ completion: @escaping (Result<Data, Error>) -> ())
}
