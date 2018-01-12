//
//  ToutiaohaoCell.swift
//  SwiftNewsDemo
//
//  Created by he.xu on 2018/1/12.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import UIKit
import IBAnimatable

class ToutiaohaoCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    
    @IBOutlet weak var concernNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var badgeLabel: AnimatableLabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
