//
//  JFPresentationController.swift
//  popoverDemo
//
//  Created by jianfeng on 15/11/9.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

import UIKit

class JFPresentationController: UIPresentationController {
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // 设置容器视图透明背景
        containerView?.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        // 呈现视图尺寸
        let popWidth: CGFloat = 200
        let popHeight: CGFloat = 300
        
        presentedView()?.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width - popWidth) * 0.5, 56, popWidth, popHeight)
        
        // 添加点击手势
        let tap = UITapGestureRecognizer(target: self, action: "didTappedContainerView")
        containerView?.addGestureRecognizer(tap)
    }
    
    /**
     容器视图区域的点击手势
     */
    @objc private func didTappedContainerView() {
        NSNotificationCenter.defaultCenter().postNotificationName("PopoverDismiss", object: nil)
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}