//
//  Constants.swift
//  Book
//
//  Created by guohui on 16/6/29.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
let MainWindow = UIApplication.sharedApplication().delegate!.window!!


var ScreenMidX:CGFloat{
    return CGRectGetMidX(UIScreen.mainScreen().bounds)
}
var ScreenMidY:CGFloat{
    return CGRectGetMidY(UIScreen.mainScreen().bounds)
}



/// 动态得到当前屏幕宽高比
var ScreenRatio:CGFloat{
    return ScreenWidth / ScreenHeight
}
var ScreenWidth:CGFloat{
    return UIScreen.mainScreen().bounds.size.width
}
var ScreenHeight:CGFloat{
    return UIScreen.mainScreen().bounds.size.height
}



class Constants: NSObject {

}
