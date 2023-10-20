//
//  BannerRepresentableViewController.swift
//  book_app
//
//  Created by Matvey on 20.10.2023.
//

import UIKit

protocol BannerRepresentableViewControllerDelegate: AnyObject {
  func loadImage(for url: String, competion: @escaping (Data) -> ())
  func didTapped(with banner: TopBannerSlide)
}

class BannerRepresentableViewController: UIViewController {
   
  weak var delegate: BannerRepresentableViewControllerDelegate?
  
  private var banner: TopBannerSlide
  
  private var bannerImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    return $0
  }(UIImageView(frame: .zero))
  
  init(with banner: TopBannerSlide, and delegate: BannerRepresentableViewControllerDelegate) {
    self.banner = banner
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
    self.loadImage()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    bannerImageView.frame = view.bounds
    bannerImageView.clipsToBounds = true
  }
  
  private func loadImage() {
    delegate?.loadImage(for: banner.cover, competion: { [weak self] (imageData) in
      DispatchQueue.main.async {
        guard let self else { return }
        UIView.transition(with: self.bannerImageView,
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: { self.bannerImageView.image = UIImage(data: imageData) },
                          completion: nil)
      }
    })
  }
}
