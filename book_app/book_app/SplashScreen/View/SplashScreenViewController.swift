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
  
  init(viewModel: SplashScreenViewModelInput) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    print("slpash")
  }
}
