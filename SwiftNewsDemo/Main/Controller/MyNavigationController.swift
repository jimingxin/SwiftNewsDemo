//
//  MyNavigationController.swift
//  SwiftNewsDemo
//
//  Created by mingxin.ji on 2018/1/3.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//
// 自定义导航条

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
            
        }
        super.pushViewController(viewController, animated: true)
    }
    
    
    @objc func navigationBack() {
        popViewController(animated: true)
    }
}

// 全局手势返回
extension MyNavigationController: UIGestureRecognizerDelegate{
    
    /// 全局拖拽手势
    fileprivate func initGlobalPan()  {
        // 创建Pand手势
        let target = interactivePopGestureRecognizer?.delegate
        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        globalPan.delegate = self
        self.view.addGestureRecognizer(globalPan);
        
        // 2 禁止系统的手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - 什么时候支持全屏手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count != 1
    }
    
}
