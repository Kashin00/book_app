//
//  SplashScreenLoadingView.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

final class SplashScreenLoadingView: UIView {
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "book_app".localized
    $0.textAlignment = .center
    $0.textColor = ColorStorage.mainPink
    $0.font = UIFont(name: "Georgia-BoldItalic", size: 52)
    return $0
  }(UILabel())
  
  private lazy var subtitleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "welcome_to_app".localized
    $0.textAlignment = .center
    $0.textColor = .white.withAlphaComponent(0.8)
    $0.font = UIFont(name: "NunitoSans-Bold", size: 24)
    return $0
  }(UILabel())
  
  private lazy var progressView: UIProgressView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.trackTintColor = .white.withAlphaComponent(0.2)
    $0.progressTintColor = .white
    $0.semanticContentAttribute = .forceLeftToRight
    $0.setProgress(0.0, animated: false)
    return $0
  }(UIProgressView())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupTitleLabel()
    setupSubtitleLabel()
    setupProgressView()
  }
  
  func animate(_ completion: @escaping () -> Void) {

    progressView.progress = 1
    UIView.animate(withDuration: 2) { [weak self] in
      self?.progressView.layoutIfNeeded()
    } completion: { isFinished in
      if isFinished {
        completion()
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  private func setupSubtitleLabel() {
    addSubview(subtitleLabel)
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
      subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  private func setupProgressView() {
    addSubview(progressView)
    NSLayoutConstraint.activate([
      progressView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 44.6),
      progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
      progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
      progressView.heightAnchor.constraint(equalToConstant: 6),
      progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}
