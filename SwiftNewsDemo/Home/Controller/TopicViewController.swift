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
        
        setupUI()
        
        if self.topicTitle?.category == "subscription" {
            tableView.tableHeaderView = toutiaohaoHeaderView
        }
    
        /// 设置上拉和下拉刷新
        setRefresh()
        
        /// 设置通知监听 tabbar 点击
        NotificationCenter.default.addObserver(self, selector: #selector(tabBarSelected), name: NSNotification.Name(rawValue: TabBarDidSelectedNotification), object: nil)
        
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

extension TopicViewController {
    
    // 设置 UI
    fileprivate func setupUI() -> Void {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.top.equalTo(view)
        }
    }
    
    // 设置下拉刷新
    
    @objc fileprivate func setRefresh() {
        
        
        let header = RefreshHeder {
            NetworkTool.loadHomeCategoryNewsFeed(category: self.topicTitle!.category!, completionHsndler: { (nowTime, newsTopics) in
                self.tableView.mj_header.endRefreshing()
                self.newsTopics = newsTopics
                self.tableView.reloadData()
            })
        }
        
        
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: self!.topicTitle!.category!) { (nowTime, newsTopics) in
                self!.tableView.mj_footer.endRefreshing()
                if newsTopics.count == 0 {
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    SVProgressHUD.showInfo(withStatus: "没有更多新闻啦~")
                    return
                }
                self!.newsTopics += newsTopics
                self!.tableView.reloadData()
            }
        })
    }
    
    /// 监听 tabbar 点击
    @objc fileprivate func tabBarSelected() {
        if lastSelectedIndex != tabBarController!.selectedIndex {
            tableView.mj_header.beginRefreshing()
        }
        lastSelectedIndex = tabBarController!.selectedIndex
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
        if topicTitle!.category == "video" {
            return showVideoCell(indexPath: indexPath)
        } else if(topicTitle!.category == "subscription"){ // 头条号
            let cell = Bundle.main.loadNibNamed(String(describing: ToutiaohaoCell.self), owner: nil, options: nil)?.last as! ToutiaohaoCell
            
            return cell
            
        } else if(topicTitle!.category == "essay_joke"){ // 段子
            let cell = Bundle.main.loadNibNamed(String(describing: HomeJokeCell.self), owner: nil, options: nil)?.last as! HomeJokeCell
            cell.isJoke = true
            cell.joke = newsTopics[indexPath.row]
            return cell
        } else if(topicTitle!.category == "组图"){ // 组图
            let cell = Bundle.main.loadNibNamed(String(describing: HomeImageTableCell.self), owner: nil, options: nil)?.last as! HomeImageTableCell
            cell.homeImage = newsTopics[indexPath.row]
            return cell
            
        } else if topicTitle!.category == "image_ppmm" { // 组图
            let cell = Bundle.main.loadNibNamed(String(describing:  HomeJokeCell.self), owner: nil, options: nil)?.last as! HomeJokeCell
            cell.isJoke = false
            cell.joke = newsTopics[indexPath.row]
            return cell
        } else{
            
            let weitoutiao = newsTopics[indexPath.row]
            if weitoutiao.cell_type! == 32 { // 用户
                let cell = Bundle.main.loadNibNamed(String(describing: HomeUserCell.self), owner: nil, options: nil)?.last as! HomeUserCell
                cell.weitoutiao = newsTopics[indexPath.row]
                return cell
            }else if weitoutiao.cell_type == 50 { // 相关关注
                let cell = Bundle.main.loadNibNamed(String(describing:  TheyAlsoUseCell.self), owner: nil, options: nil)?.last as!  TheyAlsoUseCell
                cell.theyUse = newsTopics[indexPath.row]
                return cell

            }
            
            let cell = Bundle.main.loadNibNamed(String(describing: HomeTopicCell.self), owner: nil, options: nil)?.last as! HomeTopicCell
            cell.weitoutiao = weitoutiao
            if weitoutiao.has_video! {
                cell.videoView.imageButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
                    self!.getRealVideoURL(weitoutiao: weitoutiao)
                }).disposed(by: disposeBag)
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weitoutiao = newsTopics[indexPath.row]
        
        if indexPath.row == 0 && topicTitle?.category == "" {
            let newsDetailImageVC = NewsDetailImageController.loadStoryboard()
            newsDetailImageVC.isSelectedFirstCell = true
            weitoutiao.item_id = 6450240420034118157
            weitoutiao.group_id = 6450237670911852814
            newsDetailImageVC.weitoutiao = weitoutiao
            present(newsDetailImageVC, animated: false, completion: nil)
        }else {
            if topicTitle!.category == "video" || weitoutiao.has_video! {
                /// 获取视频的真实链接
                getRealVideoURL(weitoutiao: weitoutiao)
            } else if topicTitle!.category == "subscription" {
                
            } else if topicTitle!.category == "组图" {
                
            } else if topicTitle!.category == "essay_joke" {
                
            } else if topicTitle!.category == "image_ppmm" {
                
            } else if (weitoutiao.source != nil && weitoutiao.source == "悟空问答") { // 悟空问答
//                let questionAnswerVC = QuestionAnswerController()
//                questionAnswerVC.weitoutiao = weitoutiao
//                questionAnswerVC.topicTitle = topicTitle
//                navigationController?.pushViewController(questionAnswerVC, animated: true)
            } else if (weitoutiao.has_image != nil && weitoutiao.has_image!) { // 说明有图片
                //loadNewsDetail(weitoutiao: weitoutiao)
            } else { // 一般的新闻
                //loadNewsDetail(weitoutiao:  weitoutiao)
            }
        }
    }
    
    /// 获取视频的真实链接跳转到视频详情控制器
    private func getRealVideoURL(weitoutiao: WeiTouTiao) {
        NetworkTool.parseVideoRealURL(video_id: weitoutiao.video_id!) { (realVideo) in
//            let videoDetailVC = VideoDetailController()
//            videoDetailVC.videoTopic = weitoutiao
//            videoDetailVC.realVideo = realVideo
//            self.navigationController?.pushViewController(videoDetailVC, animated: true)
        }
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
