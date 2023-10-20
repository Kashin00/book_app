//
//  BannersPageViewController.swift
//  book_app
//
//  Created by Matvey on 19.10.2023.
//

import UIKit

class BannersPageViewController: UIPageViewController {

  private lazy var pages: [UIViewController] = []
  private var switchPageSlider: Timer?
  
  private lazy var pageControl: UIPageControl = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.currentPage = 0
    $0.pageIndicatorTintColor = UIColor.gray
    $0.currentPageIndicatorTintColor = ColorStorage.mainPink
    return $0
  }(UIPageControl())
  
  private var currentViewControllerIndex: Int? {
    
    guard let vcs = viewControllers,
          let currentIndex = pages.firstIndex(of: vcs[0])
    else { return nil }
    
    return currentIndex
  }
  
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
  
  private func configurePageControl() {
    view.addSubview(pageControl)
    
    NSLayoutConstraint.activate([
      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
    ])
    
    pageControl.addTarget(self, action: #selector(self.didChangePageControlValue), for: .valueChanged)
  }
  
  private func updatePageControl() {
    guard let currentIndex = currentViewControllerIndex else { return }
    self.pageControl.currentPage = currentIndex
  }
  
  @objc private func didChangePageControlValue() {
    guard let currentIndex = currentViewControllerIndex else { return }
    restartTimer()
    let newIndex = pageControl.currentPage
    let direction: UIPageViewController.NavigationDirection = newIndex > currentIndex ? .forward : .reverse
    setViewControllers([pages[newIndex]], direction: direction, animated: true)
  }
  
  @objc private func autoSwipe() {
    guard let currentIndex = currentViewControllerIndex else { return }
    let nextIndex = (currentIndex + 1) % pages.count
    setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
    updatePageControl()
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
