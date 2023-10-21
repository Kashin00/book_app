//
//  UIApplication+Extensions.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

extension UIApplication {
  var keyWindowInConnectedScenes: UIWindow? {
    return connectedScenes
      .map { $0 as? UIWindowScene }
      .compactMap { $0 }
      .first?.windows
      .filter { $0.isKeyWindow }.first
  }
}
