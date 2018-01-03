//
//  MyTabBarController.swift
//  SwiftNewsDemo
//
//  Created by mingxin.ji on 2018/1/3.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//
// 自定义底部tabbar控制器

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor(red: 245 / 255, green: 90 / 255, blue: 93 / 255, alpha: 1)
        
        
    }
    
    /**
     * 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController(childController: HomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectedImage: "home_tabbar_press_32x32_")
        addChildViewController(childController: VideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectedImage: "video_tabbar_press_32x32_")
        addChildViewController(childController: WeiTouTiaoViewController(), title: "微头条", imageName: "weitoutiao_tabbar_32x32_", selectedImage: "weitoutiao_tabbar_press_32x32_")
        addChildViewController(childController: MineViewController(), title: "未登录", imageName: "no_login_tabbar_32x32_", selectedImage: "no_login_tabbar_press_32x32_")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImage: String)  {
        
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        childController.title = title
        let navC = MyNavigationController(rootViewController :childController);
        
        navC.navigationItem.title = title;
        addChildViewController(navC)
        
    }

}
