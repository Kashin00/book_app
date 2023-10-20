//
//  BookCharacteristicView.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

class BookCharacteristicView: UIView {
  
  private lazy var titleLabel: UILabel = {
    $0.textColor = .black
    $0.numberOfLines = 1
    $0.font = UIFont(name: "NunitoSans-Bold", size: 18)
    $0.textAlignment = .center
    return $0
  }(UILabel(frame: .zero))
  
  private lazy var subTitleLabel: UILabel = {
    $0.textColor = ColorStorage.detailsGray
    $0.numberOfLines = 1
    $0.font = UIFont(name: "NunitoSans-SemiBold", size: 12)
    $0.textAlignment = .center
    return $0
  }(UILabel(frame: .zero))

  private lazy var labelsStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 0
    return $0
  }(UIStackView(arrangedSubviews: [titleLabel, subTitleLabel]))
  
  init(with subtitle: String) {
    super.init(frame: .zero)
    backgroundColor = .clear
    subTitleLabel.text = subtitle
    setupStackView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with title: String) {
    titleLabel.text = title
  }
  
  private func setupStackView() {
    addSubview(labelsStackView)
    NSLayoutConstraint.activate([
      labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      labelsStackView.topAnchor.constraint(equalTo: topAnchor),
      labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
}
