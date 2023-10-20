//
//  BookDescriptionView.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

protocol BookDescriptionViewDelegate: AnyObject {
  func getImage(for url: String, competion: @escaping (UIImage) -> ())
}

class BookDescriptionView: UIView {
  
  weak var delegate: BookDescriptionViewDelegate?

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
  
  private lazy var alsoLikeView: AlsoLikeView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(AlsoLikeView())
  
  private lazy var readNowButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setTitle("Read Now", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = UIFont(name: "NunitoSans-ExtraBold", size: 16)
    $0.backgroundColor = ColorStorage.mainPink
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 23
    return $0
  }(UIButton())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  func configure(with book: Book) {
    readersView.configure(with: book.views)
    likesView.configure(with: book.likes)
    quotesView.configure(with: book.quotes)
    genreView.configure(with: book.genre)
    bookSummary.configure(with: book.summary)
  }
  
  func configure(with books: [Book]) {
    alsoLikeView.configure(with: books)
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
    setupAlsoLikeView()
    setupReadNowButton()
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
      bookSummary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])
  }
  
  func setupAlsoLikeView() {
    addSubview(alsoLikeView)
    alsoLikeView.delegate = self
    
    NSLayoutConstraint.activate([
      alsoLikeView.topAnchor.constraint(equalTo: bookSummary.bottomAnchor, constant: 16),
      alsoLikeView.leadingAnchor.constraint(equalTo: leadingAnchor),
      alsoLikeView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  func setupReadNowButton() {
    addSubview(readNowButton)

    NSLayoutConstraint.activate([
      readNowButton.topAnchor.constraint(equalTo: alsoLikeView.bottomAnchor, constant: 24),
      readNowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
      readNowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
      readNowButton.heightAnchor.constraint(equalToConstant: 48),
      readNowButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60)
    ])
  }
}

extension BookDescriptionView: AlsoLikeViewDelegate {
  func getImage(for url: String, competion: @escaping (UIImage) -> ()) {
    delegate?.getImage(for: url, competion: competion)
  }
}
