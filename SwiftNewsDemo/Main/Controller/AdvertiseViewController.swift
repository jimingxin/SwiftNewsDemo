//
//  AdvertiseViewController.swift
//  SwiftNewsDemo
//
//  Created by he.xu on 2018/1/4.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import UIKit

class AdvertiseViewController: UIViewController {

    // 延迟2秒
    private var time: TimeInterval = 4.0
    
    private var countdownTimer: Timer?
    
    @IBOutlet weak var timeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc func updateTime() {
        
        if time == 0 {
            countdownTimer?.invalidate()
            // 从sb 创建的 TabbarController 设置代理无效
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = sb.instantiateViewController(withIdentifier: String(describing: MyTabBarController.self)) as! MyTabBarController
            tabBarVC.delegate = self
            UIApplication.shared.keyWindow?.rootViewController = tabBarVC
            
        }else {
            time -= 1
            timeButton.setTitle(String(format: "%.0f s 跳过",time), for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timeButtonClicked( sender: Any) {
        countdownTimer?.invalidate() // 移除计时器
        // 从sb 创建的 TabbarController 设置代理无效
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = sb.instantiateViewController(withIdentifier: String(describing: MyTabBarController.self)) as! MyTabBarController
        tabBarVC.delegate = self
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
    }
    


}

// MARK: - 监听 tabbar 点击
extension AdvertiseViewController: UITabBarControllerDelegate{
    // 点击了哪个 tabbar
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TabBarDidSelectedNotification"), object: nil)
    }
}
