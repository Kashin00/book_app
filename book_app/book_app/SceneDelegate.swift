//
//  SceneDelegate.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  var mainCoordinator: MainCoordinator?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)
    window?.overrideUserInterfaceStyle = .dark
    
    mainCoordinator = MainCoordinator()
    mainCoordinator?.start()
    
    window?.rootViewController = mainCoordinator?.navigationController
    window?.makeKeyAndVisible()
  }
}

