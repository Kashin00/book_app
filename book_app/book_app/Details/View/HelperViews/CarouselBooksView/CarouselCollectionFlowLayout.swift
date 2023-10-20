//
//  CarouselCollectionFlowLayout.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

class CarouselCollectionFlowLayout: UICollectionViewFlowLayout {
  
  let scaleX: CGFloat = 1.25
  let scaleY: CGFloat = 1.25
  let duration: TimeInterval = 0.2
  
  private let itemHeight = 200
  private let itemWidth = 160
  
  // The prepare() methodis called to tell the collection view layout object to update the current layout.
  // Layout updates occur the first time the collection view presents its content and whenever the layout is invalidated.
  
  override func prepare() {
    guard let collectionView = collectionView else { return }
    
    scrollDirection = .horizontal
    itemSize = CGSize(width: itemWidth, height: itemHeight)
    
    let horizontalInsets = (collectionView.frame.size.width - itemSize.width) / 2
    
    collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInsets, bottom: 0, right: horizontalInsets)
    minimumLineSpacing = (itemSize.width * 1.25 - itemSize.width)
  }
  
}
