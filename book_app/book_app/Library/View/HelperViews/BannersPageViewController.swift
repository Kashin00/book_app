//
//  BannersPageViewController.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class BannersPageViewController: UIPageViewController {
  
  private lazy var pageControl: UIPageControl = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.currentPage = 0
    $0.pageIndicatorTintColor = UIColor.gray
    $0.currentPageIndicatorTintColor = ColorStorage.mainPink
    return $0
  }(UIPageControl())
  
  private lazy var pages: [UIViewController] = []
  private var switchPageSlider: Timer?
  
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
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    switchPageSlider?.invalidate()
  }
  
  func configure(with viewControllers: [UIViewController]) {
    pages = viewControllers
    setViewControllers([pages[0]], direction: .forward, animated: true)
    view.bringSubviewToFront(pageControl)
    pageControl.numberOfPages = pages.count
    restartTimer()
  }
  
  private func restartTimer() {
    switchPageSlider?.invalidate()
    switchPageSlider = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoSwipe), userInfo: nil, repeats: true)
  }
  
  @objc func autoSwipe() {
    if let currentPresentedVC = viewControllers?.first,
       let index = pages.firstIndex(of: currentPresentedVC) {
      let nextIndex = (index + 1) % pages.count
      setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
      updatePageControl()
    }
  }
  
  private func configurePageControl() {
    view.addSubview(pageControl)
    
    NSLayoutConstraint.activate([
      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
    ])
  }
  
  private func updatePageControl() {
    guard let vcs = viewControllers else { return }
    guard let currentIndex = pages.firstIndex(of: vcs[0]) else { return }
    self.pageControl.currentPage = currentIndex
  }
  

}

extension BannersPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController) else {
      return nil
    }
    restartTimer()
    let previousIndex = (index - 1 + pages.count) % pages.count
    return pages[previousIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController) else {
      return nil
    }
    restartTimer()
    let nextIndex = (index + 1) % pages.count
    return pages[nextIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    updatePageControl()
  }
}
