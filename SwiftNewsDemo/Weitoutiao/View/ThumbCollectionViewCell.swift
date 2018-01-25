//
//  ThumbCollectionViewCell.swift
//  SwiftNewsDemo
//
//  Created by mingxin.ji on 2018/1/25.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import UIKit
import Kingfisher

class ThumbCollectionViewCell: UICollectionViewCell, RegisterCellOrNib {

    @IBOutlet weak var galleryCountLabel: UILabel!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.borderColor = UIColor(r: 240, g: 240, b: 240).cgColor
        thumbImageView.layer.borderWidth = 1
        
    }

    var thumbImageURL: String? {
        didSet {
            thumbImageView.kf.setImage(with: URL(string: thumbImageURL!))
        }
    }
}
