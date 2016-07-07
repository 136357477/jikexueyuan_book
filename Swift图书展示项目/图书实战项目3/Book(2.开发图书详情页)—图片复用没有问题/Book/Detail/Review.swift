//
//  Review.swift
//  Book
//
//  Created by guohui on 16/6/28.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
/// 解析评论的类
class Review: NSObject {
    var id = 0
    var title = ""
    var alt = "" //html 格式,评论详情 url
    var author = Author()//评论作者信息
    var rating:Rating? //评论评分
    var votes = 0
    var useless = 0
    var comments = 0 //评论数量
    var summary = "" //评论摘要
    var published = "" //评论发表时间
    var updated = "" //上一次更新评论时间
    
    init(dict:[String:NSObject]) {
        id = dict["id"] as? Int ?? 0
        title = dict["title"] as? String ?? ""
        alt = dict["alt"] as? String ?? ""
        if let authorDic = dict["author"] as? [String:AnyObject] {
            author = Author(dict: authorDic)
        }
        if let ratingDict = dict["rating"] as? [String:NSObject]{
            rating = Rating(dict: ratingDict)
        }
        votes = dict["votes"] as? Int ?? 0
        useless = dict["useLess"] as? Int ?? 0
        comments = dict["comments"] as? Int ?? 0
        summary = dict["summary"] as? String ?? ""
        published = dict["published"] as? String ?? ""
        updated = dict["updated"] as? String ?? ""
    }
    
    
    
    
    
    
    
    
}
