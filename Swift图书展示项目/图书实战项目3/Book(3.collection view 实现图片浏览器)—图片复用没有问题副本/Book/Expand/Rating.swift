//
//  Rating.swift
//  Book
//
//  Created by guohui on 16/6/23.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class Rating: NSObject {
    let KeyAverager = "average"
    let KeyMax = "max"
    let KeyMin = "min"
    
    let KeyNumRaters = "numRaters"
    
    
    
    var averager = 0.0 //网络返回的评分
    var max = 10.0
    var min = 0.0
    var numRaters = 0.0 //
    
    // 构造评分的数据结构
    init(dict:[String:NSObject]) {
        /**
         *  强转失败 默认0.0
         */
        min = dict[KeyMin] as? Double ?? 0.0
        numRaters = dict[KeyNumRaters] as? Double ?? 0.0
        max = dict[KeyMax] as? Double ?? 5.0
        // 评分默认是 5 ,但是服务器 返回的可能是 5进制也可能是十进制
        let ratio = 5 / max
        //最大值 改为 5
        //返回时数据是 string类型 ,强转失败 默认值0
        averager = Double(dict[KeyAverager] as? String ?? "") ?? 0.0
        averager = averager * ratio // 转化为5进制
        
        
    }
    
    
    
}
