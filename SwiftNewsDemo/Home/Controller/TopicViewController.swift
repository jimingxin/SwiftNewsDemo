//
//  TopicViewController.swift
//  SwiftNewsDemo
//
//  Created by he.xu on 2018/1/9.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BMPlayer
import SnapKit
import MJRefresh
import SVProgressHUD

class TopicViewController: UIViewController {

    var lastSelectedIndex = 0
    
    // 播放器
    fileprivate lazy var player = BMPlayer()
    
    fileprivate lazy var disposeBag = DisposeBag()
    
    // 记录点击的顶部标题
    var topicTitle: TopicTitle?
    
    // 存放新闻主题的数组
    fileprivate lazy var newsTopics = [WeiTouTiao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate lazy var toutiaohaoHeaderView: ToutiaohaoHeaderView = {
        let toutiaohaoHeaderView = ToutiaohaoHeaderView()
        toutiaohaoHeaderView.height = 56
        toutiaohaoHeaderView.delegate = self
        return toutiaohaoHeaderView
        
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 232
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0)
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return tableView
    }()

}

// MARK: - 头条号的代理
extension TopicViewController: ToutiaohaoHeaderViewDelegate {
    
    func toutiaohaoHeaderViewMoreConcernButtonClicked() {
//        navigationController?.pushViewController(ConcernToutiaohaoController(), animated: true)
    }
    
}

// MARK: - Tableview DataSource
extension TopicViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if topicTitle!.category == "video" {
            return screenHeight * 0.4
        } else if topicTitle!.category == "subscription" { // 头条号
            return 68
        } else if topicTitle!.category == "essay_joke" { // 段子
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.jokeCellHeight!
        } else if topicTitle!.category == "组图" { // 组图
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.imageCellHeight!
        } else if topicTitle!.category == "image_ppmm" { // 组图
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.girlCellHeight!
        } else {
            let weitoutiao = newsTopics[indexPath.row]
            if weitoutiao.cell_type! == 32 { // 用户
                let weitoutiao = newsTopics[indexPath.row]
                return weitoutiao.contentHeight!
            } else if weitoutiao.cell_type! == 50 { // 他们也在用头条
                return 290
            }
            return weitoutiao.homeCellHeight!
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topicTitle?.category == "subscription" {
            return 10
        } else {
            return newsTopics.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if topicTitle?.category == "vide" {
            return showVideoCell(indexPath: indexPath)
        }
        
        return UITableViewCell()
    }
    
    private func showVideoCell(indexPath: IndexPath) -> VideoTopicCell {
        let cell = Bundle.main.loadNibNamed(String(describing: VideoTopicCell.self), owner: nil, options: nil)?.last as! VideoTopicCell
        
        cell.videoTopic = newsTopics[indexPath.row]
        cell.headCoverButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { () in
            
        }).disposed(by:disposeBag)
        
        // 评论按钮点击
        cell.commentButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { () in
            
        }).disposed(by: disposeBag)
        
        
        // 播放按钮点击
        cell.bgImageButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { () in
            
        }).disposed(by: disposeBag)
        return cell
    }
    
    
}
