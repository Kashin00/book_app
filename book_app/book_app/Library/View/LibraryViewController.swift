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
    setupLibraryCollectionView()
  }
  
  private func setupLibraryCollectionView() {
    view.addSubview(libraryCollectionView)
    libraryCollectionView.frame = view.bounds
    libraryCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    libraryCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BookCollectionViewCell.self))
    libraryCollectionView.register(LibrarySectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: LibrarySectionHeaderView.self))
    libraryCollectionView.register(LibraryHeaderView.self, forSupplementaryViewOfKind: LibraryHeaderView.kind, withReuseIdentifier: String(describing: LibraryHeaderView.self))
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
      switch kind {
      case LibraryHeaderView.kind:
        guard let headerView = self?.libraryCollectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: String(describing: LibraryHeaderView.self),
          for: indexPath) as? LibraryHeaderView else { return UICollectionReusableView() }

      
        return headerView
      default:
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
    
    let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                         heightDimension: .fractionalHeight(0.43)),
      elementKind: LibraryHeaderView.kind,
      alignment: .top)
    
    config.boundarySupplementaryItems = [globalHeader]
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
