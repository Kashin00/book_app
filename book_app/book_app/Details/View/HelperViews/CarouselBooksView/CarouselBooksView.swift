//
//  CarouselBooksView.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

protocol CarouselBooksViewDelegate: AnyObject {
  func getImage(for url: String, competion: @escaping (Data) -> ())
}

class CarouselBooksView: UIView {
  
  weak var delegate: CarouselBooksViewDelegate?
  
  private var books: [Book] = []
  
  //  private lazy var backButton: UIButton = {
  //    $0.translatesAutoresizingMaskIntoConstraints = false
  //    $0.setImage(UIImage(named: ImageStorage.backArrow), for: .normal)
  //    return $0
  //  }(UIButton())
  
  private lazy var carouselCollectionViewLayout = CarouselCollectionFlowLayout()
  
  private lazy var carouselCollectionView: UICollectionView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(BookPosterCollectioViewCell.self, forCellWithReuseIdentifier: String(describing: BookPosterCollectioViewCell.self))
    $0.delegate = self
    $0.dataSource = self
    return $0
  }(UICollectionView(frame: .zero, collectionViewLayout: carouselCollectionViewLayout))
  
  private var currentSelectedIndex = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCollectionView()
    carouselCollectionView.reloadData()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with books: [Book]) {
    self.books = books
    carouselCollectionView.reloadData()
  }
}

//MARK: UI
private extension CarouselBooksView {
  func setupCollectionView() {
    addSubview(carouselCollectionView)
    
    NSLayoutConstraint.activate([
      carouselCollectionView.topAnchor.constraint(equalTo: topAnchor),
      carouselCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      carouselCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      carouselCollectionView.heightAnchor.constraint(equalToConstant: 250)
    ])
  }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension CarouselBooksView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return books.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: BookPosterCollectioViewCell.self),
      for: indexPath) as? BookPosterCollectioViewCell
    else { return BookPosterCollectioViewCell() }
    
    cell.configure(with: books[indexPath.item], and: self)
    
    
    //    if currentSelectedIndex == indexPath.row {
    //      cell.transformToLarge(with: carouselCollectionViewLayout.duration,
    //                            scaleX: carouselCollectionViewLayout.scaleX,
    //                            scaleY: carouselCollectionViewLayout.scaleY)
    //    }
    
    return cell
  }
}

// MARK: ScrollView methods

extension CarouselBooksView {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    let currentCell = carouselCollectionView.cellForItem(at: IndexPath(row: Int(currentSelectedIndex), section: 0))
    currentCell?.transformToStandard(with: carouselCollectionViewLayout.duration)
    
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    guard scrollView == carouselCollectionView,
          let flowLayout = carouselCollectionView.collectionViewLayout as? CarouselCollectionFlowLayout
    else { return }
    
    targetContentOffset.pointee = scrollView.contentOffset
    
    let cellWidthIncludingSpacing = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
    let offset = targetContentOffset.pointee
    let horizontalVelocity = velocity.x
    
    var selectedIndex = currentSelectedIndex
    
    switch horizontalVelocity {
      // On swiping
    case _ where horizontalVelocity > 0 :
      selectedIndex = currentSelectedIndex + 1
    case _ where horizontalVelocity < 0:
      selectedIndex = currentSelectedIndex - 1
      
      // On dragging
    case _ where horizontalVelocity == 0:
      let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
      let roundedIndex = round(index)
      
      selectedIndex = Int(roundedIndex)
    default:
      print("Incorrect velocity for collection view")
    }
    
    let safeIndex = max(0, min(selectedIndex, books.count - 1))
    let selectedIndexPath = IndexPath(row: safeIndex, section: 0)
    
    flowLayout.collectionView!.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
    
    let previousSelectedIndex = IndexPath(row: Int(currentSelectedIndex), section: 0)
    let previousSelectedCell = carouselCollectionView.cellForItem(at: previousSelectedIndex)
    let nextSelectedCell = carouselCollectionView.cellForItem(at: selectedIndexPath)
    
    currentSelectedIndex = selectedIndexPath.row
    
    previousSelectedCell?.transformToStandard(with: carouselCollectionViewLayout.duration)
    nextSelectedCell?.transformToLarge(with: carouselCollectionViewLayout.duration,
                                       scaleX: carouselCollectionViewLayout.scaleX,
                                       scaleY: carouselCollectionViewLayout.scaleY)
  }
}


extension CarouselBooksView: BookPosterCollectioViewCellDelegate {
  func getImage(for url: String, competion: @escaping (Data) -> ()) {
    delegate?.getImage(for: url, competion: competion)
  }
}
