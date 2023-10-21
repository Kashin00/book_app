//
//  BookSummaryView.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

class BookSummaryView: UIView {
  
  private lazy var topDevider: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = ColorStorage.detailsGray
    return $0
  }(UIView())
  
  private lazy var bottomDevider: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = ColorStorage.detailsGray
    return $0
  }(UIView())
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "summary".localized
    $0.textColor = .black
    $0.numberOfLines = 1
    $0.font = UIFont(name: "NunitoSans-Bold", size: 20)
    return $0
  }(UILabel(frame: .zero))
  
  private lazy var descriptionLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .black
    $0.numberOfLines = 0
    $0.font = UIFont(name: "NunitoSans-SemiBold", size: 14)
    return $0
  }(UILabel(frame: .zero))
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with description: String) {
    descriptionLabel.text = description
  }
  
  private func setupUI() {
    setupDeviders()
    setupTitleLabel()
    setupDescriptionLabel()
  }
  
  private func setupDeviders() {
    addSubview(topDevider)
    addSubview(bottomDevider)
    
    NSLayoutConstraint.activate([
      topDevider.topAnchor.constraint(equalTo: topAnchor),
      topDevider.leadingAnchor.constraint(equalTo: leadingAnchor),
      topDevider.trailingAnchor.constraint(equalTo: trailingAnchor),
      topDevider.heightAnchor.constraint(equalToConstant: 1),
      
      bottomDevider.bottomAnchor.constraint(equalTo: bottomAnchor),
      bottomDevider.leadingAnchor.constraint(equalTo: leadingAnchor),
      bottomDevider.trailingAnchor.constraint(equalTo: trailingAnchor),
      bottomDevider.heightAnchor.constraint(equalToConstant: 1),
    ])
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topDevider.bottomAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
    ])
  }
  
  private func setupDescriptionLabel() {
    addSubview(descriptionLabel)
    
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: bottomDevider.topAnchor, constant: -16)
    ])
  }
}
