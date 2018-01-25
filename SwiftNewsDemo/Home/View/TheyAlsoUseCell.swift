//
//  TheyAlsoUseCell.swift
//  SwiftNewsDemo
//
//  Created by mingxin.ji on 2018/1/25.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import UIKit

class TheyAlsoUseCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var theyUse: WeiTouTiao? {
        didSet {
            leftLabel.text = theyUse!.title! as String
            rightButton.setTitle(theyUse!.show_more!, for: .normal)
            userCards = theyUse!.user_cards
            collectionView.reloadData()
        }
    }
    
    var userCards = [UserCard]()
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.theme_backgroundColor = "colors.separatorColor"
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 215)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: TheyUseCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TheyUseCollectionCell.self))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension TheyAlsoUseCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TheyUseCollectionCell.self), for: indexPath) as! TheyUseCollectionCell
        cell.userCard = userCards[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 15, 10, 10)
    }
    
}
