//
//  JFHomeViewController.swift
//  popoverDemo
//
//  Created by jianfeng on 15/11/9.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

import UIKit

class JFHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()

        // 自定义标题
        let titleButton = JFTitleButton(title: "六阿哥")
        navigationItem.titleView = titleButton
        titleButton.addTarget(self, action: "didTappedTitleButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "popoverDismiss", name: "PopoverDismiss", object: nil)
        
    }
    
    // 自定义标题按钮点击事件
    @objc private func didTappedTitleButton(button: JFTitleButton) {
        
        // 改变箭头方向
        button.selected = !button.selected
        
        // 标题下的控制器
        let vc = JFPopViewController()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // 通知方法
    @objc private func popoverDismiss() {
        
        let button = self.navigationItem.titleView as! JFTitleButton
        button.selected = false
    }
    
    deinit {
        // 注销通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

// MARK: - UIViewControllerTransitioningDelegate委托方法
extension JFHomeViewController: UIViewControllerTransitioningDelegate {
    
    // 返回一个控制modal视图大小的对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return JFPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    // 返回一个控制器modal动画效果的对象
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JFPopoverModalAnimation()
    }
    
    // 返回一个控制dismiss动画效果的对象
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JFPopoverDismissAnimation()
    }
}
