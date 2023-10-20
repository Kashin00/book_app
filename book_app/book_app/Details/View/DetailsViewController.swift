//
//  DetailsViewController.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

class DetailsViewController: UIViewController {
  
  private var viewModel: DetailsViewModelInput?
  
  init(viewModel: DetailsViewModelInput) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
//    bindViewModel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
