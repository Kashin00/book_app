//
//  LibrarySectionHeaderView.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class LibrarySectionHeaderView: UICollectionReusableView {
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = UIFont(name: "NunitoSans-Bold", size: 20)
    $0.textColor = .white
    return $0
  }(UILabel(frame: .zero))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    setupLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView(with title: String) {
    titleLabel.text = title
  }
  
  private func setupLabel() {
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
}
