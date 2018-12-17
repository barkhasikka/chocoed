//
//  RootUIPageViewController.swift
//  chocoed
//
//  Created by Tejal on 17/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class RootUIPageViewController: UIPageViewController,UIPageViewControllerDataSource{
    lazy var viewcontrollerList:[UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "RedVC")
        let vc2 = sb.instantiateViewController(withIdentifier: "orangeVC")
        let vc3 = sb.instantiateViewController(withIdentifier: "BlueVC")
        return [vc1,vc2,vc3]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        if let firstViewController = viewcontrollerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
     }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewcontrollerList.index(of: viewController) else{return nil}
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else{return nil}
        
        guard viewcontrollerList.count > previousIndex  else {return nil}
          return viewcontrollerList[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewcontrollerList.index(of: viewController) else{return nil}
        let nextIndex = vcIndex + 1
        
        guard viewcontrollerList.count != nextIndex else{return nil}
        guard viewcontrollerList.count > nextIndex else {return nil}
        return viewcontrollerList[nextIndex]
}
}
