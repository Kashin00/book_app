//
//  BannersPageViewController.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class BannersPageViewController: UIPageViewController {
  
  let vc1 = UIViewController()
  let vc2 = UIViewController()
  
  private lazy var pageControl: UIPageControl = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.currentPage = 0
    $0.pageIndicatorTintColor = UIColor.gray
    $0.currentPageIndicatorTintColor = ColorStorage.mainPink
    return $0
  }(UIPageControl())
  
  lazy var pages = [vc1, vc2]
  
  override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    setViewControllers([pages[0]], direction: .forward, animated: true)
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
    
    vc1.view.backgroundColor = .red
    vc2.view.backgroundColor = .yellow
    configurePageControl()
    
  }
  
  func configurePageControl() {
    
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
