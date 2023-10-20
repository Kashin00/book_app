//
//  DetailsViewController.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

class DetailsViewController: UIViewController {
  
  private var viewModel: DetailsViewModelInput?
  
  private lazy var scrollView = UIScrollView()
  private lazy var carouselView = CarouselBooksView()
  private lazy var bookDescriptionView = BookDescriptionView()
  
  init(viewModel: DetailsViewModelInput) {
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

//MARK: UI
private extension DetailsViewController {
  func setupUI() {
    navigationController?.isNavigationBarHidden = true
    view.backgroundColor = .black
    setupScrollView()
    setupCarouselBooksView()
    setupBookDescriptionView()
  }
  
  func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)
    scrollView.addSubview(carouselView)
    scrollView.addSubview(bookDescriptionView)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  func setupCarouselBooksView() {
    carouselView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      carouselView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      carouselView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      carouselView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      carouselView.heightAnchor.constraint(equalToConstant: 3000), // Установите высоту представления
      carouselView.bottomAnchor.constraint(equalTo: bookDescriptionView.topAnchor),
      ])
  }
  
  func setupBookDescriptionView() {
    bookDescriptionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      bookDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      bookDescriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      bookDescriptionView.heightAnchor.constraint(equalToConstant: 500), // Установите высоту представления
      bookDescriptionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
  }
}
