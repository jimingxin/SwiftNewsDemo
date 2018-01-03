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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
