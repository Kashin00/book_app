//
//  Coordinator.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }

    func start()
}
