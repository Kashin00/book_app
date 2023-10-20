//
//  BannersPageViewController.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class BannerRepresentableViewController: UIViewController {
  
  private var banner: TopBannerSlide
  
  private var bannerImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleToFill
    return $0
  }(UIImageView(frame: .zero))
  
  init(banner: TopBannerSlide) {
    self.banner = banner
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
  }
  
  private func setupImageView() {
    view.addSubview(bannerImageView)
    bannerImageView.frame = view.bounds
  }
}

class BannersPageViewController: UIPageViewController {
  
  private lazy var pageControl: UIPageControl = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.currentPage = 0
    $0.pageIndicatorTintColor = UIColor.gray
    $0.currentPageIndicatorTintColor = ColorStorage.mainPink
    return $0
  }(UIPageControl())
  
  private lazy var pages: [UIViewController] = []
  
  override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    view.backgroundColor = .black
    delegate = self
    dataSource = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 20
    
    configurePageControl()
  }
  
  func configure(with viewControllers: [UIViewController]) {
    pages = viewControllers
    setViewControllers([pages[0]], direction: .forward, animated: true)
  }
  
  private func configurePageControl() {
    view.addSubview(pageControl)
    pageControl.numberOfPages = pages.count

    NSLayoutConstraint.activate([
      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
    ])
  }
}

extension BannersPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController) else {
      return nil
    }
    let previousIndex = (index - 1 + pages.count) % pages.count
//    pageControl.currentPage = previousIndex
    return pages[previousIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController) else {
      return nil
    }
    let nextIndex = (index + 1) % pages.count
//    pageControl.currentPage = nextIndex
    return pages[nextIndex]
  }
}
