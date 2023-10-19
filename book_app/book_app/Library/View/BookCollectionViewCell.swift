//
//  BookCollectionViewCell.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

protocol BookCollectionViewCellDelegate: AnyObject {
  func getImage(for url: String, competion: @escaping (Data) -> ())
}

class BookCollectionViewCell: UICollectionViewCell {
  
  weak var delegate: BookCollectionViewCellDelegate?
  
  private lazy var posterImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 16
    $0.contentMode = .scaleAspectFill
    return $0
  }(UIImageView())
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
    $0.textColor = .white.withAlphaComponent(0.7)
    $0.numberOfLines = 2
    return $0
  }(UILabel())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupImageView()
    setupTitleLable()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell(with book: Book, and delegate: BookCollectionViewCellDelegate) {
    self.delegate = delegate
    titleLabel.text = book.name
    
    delegate.getImage(for: book.coverURL) { [weak self] (imageData) in
      self?.setImage(with: UIImage(data: imageData))
    }
  }
  
  private func setImage(with image: UIImage?) {
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      UIView.transition(with: self.posterImageView,
                        duration: 0.75,
                        options: .transitionCrossDissolve,
                        animations: { self.posterImageView.image = image },
                        completion: nil)
    }
  }
  
  private func setupImageView() {
    contentView.addSubview(posterImageView)
    NSLayoutConstraint.activate([
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      posterImageView.heightAnchor.constraint(equalToConstant: 150)
    ])
  }
  
  private func  setupTitleLable() {
    contentView.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 4),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
}
