//
//  BookDescriptionView.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit


class BookDescriptionView: UIView {

  private lazy var readersView = BookCharacteristicView(with: "Readers")
  private lazy var likesView = BookCharacteristicView(with: "Likes")
  private lazy var quotesView = BookCharacteristicView(with: "Quotes")
  private lazy var genreView = BookCharacteristicView(with: "Genre")
  
  private lazy var bookCharacteristicStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    return $0
  }(UIStackView(arrangedSubviews: [readersView, likesView, quotesView, genreView]))
  
  private lazy var bookSummary: BookSummaryView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(BookSummaryView())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

//MARK: UI
private extension BookDescriptionView {
  func setupUI() {
    backgroundColor = .white
    setupBookCharacteristicStackView()
    setupBookSummary()
  }
  
  func setupBookCharacteristicStackView() {
    addSubview(bookCharacteristicStackView)
    
    NSLayoutConstraint.activate([
      bookCharacteristicStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      bookCharacteristicStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33),
      bookCharacteristicStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33),
      bookCharacteristicStackView.heightAnchor.constraint(equalToConstant: 35)
    ])
  }
  
  func setupBookSummary() {
    addSubview(bookSummary)
    
    NSLayoutConstraint.activate([
      bookSummary.topAnchor.constraint(equalTo: bookCharacteristicStackView.bottomAnchor, constant: 10),
      bookSummary.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      bookSummary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      bookSummary.heightAnchor.constraint(equalToConstant: 100)
    ])
  }
}

