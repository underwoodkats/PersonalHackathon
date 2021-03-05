//
//  WalkthroughPageViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/10.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDelegate {
  
    // MARK: - Properties
    
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    let pages: [UIViewController] = {
        let storyboard = UIStoryboard(name: K.StoryBoard.walkthroughStoryBoardName, bundle: nil)
        
        let firstPage = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.walkthroughFirstContentViewController)
        let secondPage = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.walkthroughSecondContentViewController)
        let thirdPage = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.walkthroughThirdContentViewController)
        let fourthPage = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.walkthroughFourthContentViewController)
        
        return [firstPage, secondPage, thirdPage, fourthPage ]
    }()
    
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source and delegate to itself
        dataSource = self
        delegate = self
        
        // Create the first walkthrough screen
        if let startingViewController = pages.first {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func forwardPage() {
        currentIndex += 1
        if currentIndex >= 0 && currentIndex < pages.count {
            let nextViewController = pages[currentIndex]
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func backwardPage() {
        currentIndex -= 1
        if currentIndex >= 0 && currentIndex < pages.count {
            let nextViewController = pages[currentIndex]
            setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller Delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController,
               let index = contentViewController.pageIndex {
                currentIndex = index
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}

// MARK: - Page View Controller Data Source

extension WalkthroughPageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
    return pages[index - 1]
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
    return pages[index + 1]
  }
}
