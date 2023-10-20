//
//  DataDecoder.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import Foundation

protocol DataDecoder {}

extension DataDecoder {
  func dataDecoder<T: Decodable>(_ data: Data) throws -> T {
    do {
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      return decodedData
    } catch {
      throw error
    }
  }
}
