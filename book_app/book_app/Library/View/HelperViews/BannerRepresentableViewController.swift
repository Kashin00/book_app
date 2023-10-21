//
//  BannerRepresentableViewController.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

protocol BannerRepresentableViewControllerDelegate: AnyObject {
  func loadImage(for url: String, competion: @escaping (UIImage) -> ())
  func didTapped(with banner: TopBannerSlide)
}

class BannerRepresentableViewController: UIViewController {
   
  weak var delegate: BannerRepresentableViewControllerDelegate?
  
  private var banner: TopBannerSlide
  
  private var bannerImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView(frame: .zero))
  
  init(with banner: TopBannerSlide, and delegate: BannerRepresentableViewControllerDelegate) {
    self.banner = banner
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
    self.loadImage()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    delegate?.didTapped(with: banner)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    setupImageView()
  }
  
  private func setupImageView() {
    view.addSubview(bannerImageView)
    
    NSLayoutConstraint.activate([
      bannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
      bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bannerImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func loadImage() {
    delegate?.loadImage(for: banner.cover, competion: { [weak self] (image) in
      DispatchQueue.main.async {
        self?.bannerImageView.setImageAnimatableIfNeede(with: image)
      }
    })
  }
}
