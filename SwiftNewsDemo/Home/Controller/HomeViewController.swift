//
//  HomeViewController.swift
//  SwiftNewsDemo
//
//  Created by he.xu on 2018/1/3.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 设置导航栏的颜色
        navigationController?.navigationBar.theme_barTintColor = "colors.homeNavBarTintColor"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        view.backgroundColor = UIColor.globalBackgroundColor()
        // 设置状态栏的属性
        navigationController?.navigationBar.barStyle = .black
        // 自定义导航栏
        navigationItem.titleView = homeNavigationBar
        
        automaticallyAdjustsScrollViewInsets = false
        
        // 获取标题数据
        NetworkTool.loadHomeTitlesData(fromViewController: String(describing: HomeViewController.self)) { (topTitles, homeTopicVCs) in
            // 将所有自控制器添加到父控制器中
            
            for childVC in homeTopicVCs {
                self.addChildViewController(childVC)
            }
            
            self.setupUI()
            
            self.pageView.titles = topTitles
            self.pageView.childVcs = self.childViewControllers as? [TopicViewController]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    fileprivate lazy var pageView: HomePageView = {
        let pageView = HomePageView()
        return pageView
    }()
    
    fileprivate lazy var homeNavigationBar: HomeNavigationBar = {
        let homeNavigationBar = HomeNavigationBar()
        homeNavigationBar.searchBar.delegate = self
        return homeNavigationBar
    }()
    

}

extension HomeViewController{
    
    fileprivate func setupUI() {
        view.addSubview(pageView)
        
        pageView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
           make.top.equalTo(view).offset(kNavBarHeight + (ManagerTool.isIphoneX() ? 24 : 0 ))
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(homeTitleAddButtonClicked(notification:)), name: NSNotification.Name("homeTitleAddButtonClicked"), object: nil)
    }
    
    /// 点击了加号按钮
    @objc func homeTitleAddButtonClicked(notification: Notification) {
//        let titles = notification.object as! [TopicTitle]
//        let homeAddCategoryVC = HomeAddCategoryController.loadStoryboard()
//        homeAddCategoryVC.homeTitles = titles
//        homeAddCategoryVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - 20)))
//        present(homeAddCategoryVC, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
