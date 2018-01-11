//
//  ManagerTool.swift
//  TodayNews
//
//  Created by he.xu on 2018/1/11.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

struct ManagerTool {
    static func isIphoneX() -> Bool{
        if screenWidth == 375 && screenHeight == 812 {
            return true
        }
        return false
    }
}
