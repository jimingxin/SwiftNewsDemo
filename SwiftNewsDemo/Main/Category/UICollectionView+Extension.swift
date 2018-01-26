//
//  UICollectionView+Extension.swift
//  SwiftNewsDemo
//
//  Created by mingxin.ji on 2018/1/26.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // 注册cell
    func ym_registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let xib = T.xib {
            // T 遵守了 RegisterCellOrNib 协议，所以通过 T 就能取出 identifier 这个属性
            register(xib, forCellWithReuseIdentifier: T.identifier)
        } else {
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    // 获取可重用的 cell
    func ym_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T:RegisterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    // 注册头部
    func ym_registerSupplementaryHeaderView<T: UICollectionReusableView>(reusableView: T.Type) where T: RegisterCellOrNib{
        
        if let xib = T.xib {
            register(xib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.identifier)
        }else {
            register(reusableView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.identifier)
        }
    }
    
    /// 获取可重用的头部
    func ym_dequeueReusableSupplementaryHeaderView<T: UICollectionReusableView>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
