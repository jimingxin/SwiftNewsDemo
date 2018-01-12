//
//  HomeImageTableCell.swift
//  SwiftNewsDemo
//
//  Created by he.xu on 2018/1/12.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import UIKit
import Kingfisher

class HomeImageTableCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var homeImage: WeiTouTiao? {
        didSet{

            if let gallaryImageCount = homeImage?.gallary_image_count {
                if gallaryImageCount > 0{
                    imageCountLabel.text = "\(gallaryImageCount)图"
                }
            }
            
            imageTitleLabel.text = homeImage!.title! as String
            timeLabel.text = homeImage!.commentCount! + "评论"
            
            if let mediaInfo = homeImage!.media_info {
                usernameLabel.text = mediaInfo.name!
            }
            
             let firstImage = homeImage!.image_list.first
            bgImageView.kf.setImage(with: URL(string: firstImage!.url!))
        }
    }
    
    
}
