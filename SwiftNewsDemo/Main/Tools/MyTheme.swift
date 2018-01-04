//
//  MyTheme.swift
//  SwiftNewsDemo
//
//  Created by he.xu on 2018/1/4.
//  Copyright © 2018年 mingxin.ji. All rights reserved.
//

import Foundation
import SwiftTheme

enum MyTheme: Int {
    case day = 0
    
    case night = 1
    
    static var current = MyTheme.day
    static var before = MyTheme.day
    
    // 选择主题
    static func switchTo(_ theme: MyTheme) {
        before = current
        current = theme
        
        switch theme {
        case .day:
            ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        case .night:
            ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    
    static func switchNight(_ isToNight: Bool)  {
        switchTo(isToNight ? .night : before)
    }
    
    static func isNight() -> Bool {
        return current == .night
    }
    
}
