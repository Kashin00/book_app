//
//  LibraryViewController.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class LibraryViewController: UIViewController {
  
  private var viewModel: LibraryViewModelInput?
  
  private lazy var libraryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
  private var dataSource: UICollectionViewDiffableDataSource<BookGenre, Book>?
  
  private lazy var scrollView: UIScrollView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .clear
    return $0
  }(UIScrollView())
  
  
  
  init(viewModel: LibraryViewModelInput) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
    bindViewModel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    viewModel?.fetchData()
    setupScrollView()
    setupLibraryCollectionView()
  }
  
  func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.contentInsetAdjustmentBehavior = .never
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func setupLibraryCollectionView() {
    scrollView.addSubview(libraryCollectionView)
    libraryCollectionView.frame = scrollView.bounds
    libraryCollectionView.bounces = true
    libraryCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    libraryCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BookCollectionViewCell.self))
    libraryCollectionView.register(LibrarySectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: LibrarySectionHeaderView.self))
    libraryCollectionView.delegate = self
    createDataSource()
  }
  
  private func bindViewModel() {
    bindDataReloading()
  }
  
  private func bindDataReloading() {
    viewModel?.bindReloadData = { [weak self] in
      self?.reloadData()
    }
  }
}

// MARK: UICollectionViewDelegate
extension LibraryViewController: UICollectionViewDelegate {
  
}

//MARK: UICollectionViewDataSource
private extension LibraryViewController {
  func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<BookGenre, Book>(collectionView: libraryCollectionView, cellProvider: { collectionView, indexPath, book in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BookCollectionViewCell.self), for: indexPath) as? BookCollectionViewCell
      else { return UICollectionViewCell() }
    
      cell.configureCell(with: book, and: self)
      
      return cell
    })
    
    
    dataSource?.supplementaryViewProvider = { [weak self] (view, kind, indexPath) in
      guard let headerView = self?.libraryCollectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: String(describing: LibrarySectionHeaderView.self),
        for: indexPath) as? LibrarySectionHeaderView else { return UICollectionReusableView() }
      if let title = self?.viewModel?.library?.bookGenres[indexPath.section].genre {
        headerView.setupView(with: title)
      }
    
      return headerView
    }
  }
  
  func reloadData() {
    guard let sections = viewModel?.library?.bookGenres else { return }
    var snapshot = NSDiffableDataSourceSnapshot<BookGenre, Book>()
    snapshot.appendSections(sections)
    
    sections.forEach  {
      snapshot.appendItems($0.books, toSection: $0)
    }
    
    dataSource?.apply(snapshot)
  }
}

// MARK: UICollectionViewLayout
private extension LibraryViewController {
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
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .absolute(40.0))
    
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top)
    
    let sectionMovies = NSCollectionLayoutSection(group: group)
    sectionMovies.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16)
    sectionMovies.interGroupSpacing = 8
    sectionMovies.orthogonalScrollingBehavior = .continuous
    sectionMovies.boundarySupplementaryItems = [sectionHeader]
    
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
      return sectionMovies
    }
    
    layout.configuration = config
    return layout
  }
}

extension LibraryViewController: BookCollectionViewCellDelegate {
  func getImage(for url: String, competion: @escaping (Data) -> ()) {
    viewModel?.loadImage(for: url, competion: competion)
  }
}
