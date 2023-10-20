//
//  AlsoLikeView.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

protocol AlsoLikeViewDelegate: AnyObject {
  func getImage(for url: String, competion: @escaping (UIImage) -> ())
}

class AlsoLikeView: UIView {
  
  weak var delegate: AlsoLikeViewDelegate?
  
  private lazy var booksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
  private var dataSource: UICollectionViewDiffableDataSource<AnyHashable, Book>?
  
  private var books: [Book] = []
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "You will also like"
    $0.textColor = .black
    $0.numberOfLines = 1
    $0.font = UIFont(name: "NunitoSans-Bold", size: 20)
    return $0
  }(UILabel(frame: .zero))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
   setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with books: [Book]) {
    self.books = books
    reloadData()
  }

  private func setupUI() {
    backgroundColor = .white
    setupTitleLabel()
    setupCollectionView()
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
    ])
  }
  
  private func setupCollectionView() {
    addSubview(booksCollectionView)
    
    booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
    booksCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BookCollectionViewCell.self))
    booksCollectionView.backgroundColor = .clear
    
    NSLayoutConstraint.activate([
      booksCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
      booksCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      booksCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      booksCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      booksCollectionView.heightAnchor.constraint(equalToConstant: 200)
    ])
    
    createDataSource()
  }
  
  private func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<AnyHashable, Book>(collectionView: booksCollectionView, cellProvider: { collectionView, indexPath, book in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BookCollectionViewCell.self), for: indexPath) as? BookCollectionViewCell
      else { return UICollectionViewCell() }
    
      cell.configureCell(with: book, and: self, titleLabelTextColor: .black)
      
      return cell
    })
  }
  
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<AnyHashable, Book>()
    snapshot.appendSections([Int(1)])
    snapshot.appendItems(books)
    dataSource?.apply(snapshot)
  }
  
  func createLayout() -> UICollectionViewLayout {
    
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.scrollDirection = .vertical
    
    if #available(iOS 14.0, *) {
      config.contentInsetsReference = .none
    }
    
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
    
    let height: CGFloat = 190
    let width: CGFloat = 120
    let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(width), heightDimension: .estimated(height)), subitems: [item])
    group.interItemSpacing = .fixed(16)
    
    let sectionMovies = NSCollectionLayoutSection(group: group)
    sectionMovies.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16)
    sectionMovies.interGroupSpacing = 8
    sectionMovies.orthogonalScrollingBehavior = .continuous
    
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
      return sectionMovies
    }
    
    layout.configuration = config
    return layout
  }
}


extension AlsoLikeView: BookCollectionViewCellDelegate {
  func getImage(for url: String, competion: @escaping (UIImage) -> ()) {
    delegate?.getImage(for: url, competion: competion)
  }
}
