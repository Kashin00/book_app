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
    bindViewModel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    viewModel?.fetchData()
  }
  
  func bindViewModel() {
    bindReloadData()
  }
  
  func bindReloadData() {
    viewModel?.bindReloadData = { [weak self] in
      guard let books = self?.viewModel?.books,
            let firstBook = books.first
      else { return }
      self?.carouselView.configure(with: books)
      self?.bookDescriptionView.configure(with: firstBook)
      if let likedBooks = self?.viewModel?.favoriteBooks {
        self?.bookDescriptionView.configure(with: likedBooks)
      }
    }
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
    scrollView.backgroundColor = ColorStorage.detailsBackground

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
    carouselView.delegate = self
    
    NSLayoutConstraint.activate([
      carouselView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      carouselView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      carouselView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      carouselView.bottomAnchor.constraint(equalTo: bookDescriptionView.topAnchor),
    ])
  }
  
  func setupBookDescriptionView() {
    bookDescriptionView.translatesAutoresizingMaskIntoConstraints = false
    bookDescriptionView.delegate = self
    
    NSLayoutConstraint.activate([
      bookDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      bookDescriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      bookDescriptionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
  }
}

extension DetailsViewController: CarouselBooksViewDelegate {
  func getImage(for url: String, competion: @escaping (UIImage) -> ()) {
    viewModel?.loadImage(for: url, competion: competion)
  }
  
  func backButtonDidTap() {
    viewModel?.backButtonDidTap()
  }
}

extension DetailsViewController: BookDescriptionViewDelegate {
}
