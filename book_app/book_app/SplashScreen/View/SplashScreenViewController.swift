//
//  SplashScreenViewController.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import Foundation
import UIKit

class SplashScreenViewController: UIViewController {
  
  private var viewModel: SplashScreenViewModelInput?
  
  private lazy var backgroundImageView = UIImageView()
  
  private lazy var loadingView: SplashScreenLoadingView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .clear
    return $0
  }(SplashScreenLoadingView())
  
  init(viewModel: SplashScreenViewModelInput) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
}

//MARK: UI Setup
private extension SplashScreenViewController {
  
  func setupUI() {
    view.backgroundColor = .clear
    setupBackgroundImageView()
    setupLoadingView()
  }
  
  func setupBackgroundImageView() {
    if let layerImage = UIImage(named: ImageStorage.SplashScreen.backgroundHeartsLayer),
       let backgroundImage = UIImage(named: ImageStorage.SplashScreen.background)?.mergeWith(topImage: layerImage) {
      backgroundImageView.image = backgroundImage
    }
    backgroundImageView.frame = view.bounds
    view.addSubview(backgroundImageView)
  }
  
  func setupLoadingView() {
    view.addSubview(loadingView)
    NSLayoutConstraint.activate([
      loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
