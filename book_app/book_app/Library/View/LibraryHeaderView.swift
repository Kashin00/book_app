//
//  LibraryHeaderView.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class LibraryHeaderView: UICollectionReusableView {
  
  static let kind = "LibraryHeaderViewGlobalHeader"
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = UIColor(red: 0.817, green: 0, blue: 0.433, alpha: 1)
    $0.font = UIFont(name: "NunitoSans-Bold", size: 20)
    $0.text = "Library"
    return $0
  }(UILabel())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .black
    setupTitleLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
    ])
  }
}
