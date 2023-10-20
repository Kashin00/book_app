//
//  BookPosterCollectioViewCell.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

protocol BookPosterCollectioViewCellDelegate: AnyObject {
  func getImage(for url: String, competion: @escaping (Data) -> ())
}

class BookPosterCollectioViewCell: UICollectionViewCell {
  
  weak var delegate: BookPosterCollectioViewCellDelegate?
  
  private var book: Book?
  
  private lazy var posterImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 16
    $0.contentMode = .scaleAspectFill
    return $0
  }(UIImageView())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.layer.masksToBounds = true
    contentView.layer.cornerRadius = 16
    setupImageView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with book: Book, and delegate: BookPosterCollectioViewCellDelegate) {
    self.book = book
    self.delegate = delegate

    delegate.getImage(for: book.coverURL) { [weak self] (imageData) in
      self?.setImage(with: UIImage(data: imageData))
    }
  }
  
  private func setupImageView() {
    contentView.addSubview(posterImageView)
    NSLayoutConstraint.activate([
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
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
}
