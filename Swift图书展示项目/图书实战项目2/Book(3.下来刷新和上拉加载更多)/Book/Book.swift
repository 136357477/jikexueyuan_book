//
//  Book.swift
//  Book
//
//  Created by guohui on 16/6/14.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
//Book 的模型类
// 改为结构体
struct Book {
    
    //key
    let KeyId = "id"
    let KeyIsbn10 = "isbn10"
    let KeyIsbn13 = "isbn13"
    let KeyTitle = "title"
    let KeyOrigin_title = "origin_title"
    let KeyAlt_title = "alt_title"
    let KeySubtitle = "subtitle"
    let KeyUrl = "url"
    let KeyAlt = "alt"
    let KeyImage = "image"
    let KeyImages = "images"
    let KeyAuthor = "author"
    let KeyTranslator = "translator"
    let KeyPublisher = "publisher"
    let KeyPubdate = "pubdate"
    let KeyRating = "rating"
    let KeyTags = "tags"
    let KeyBinding = "binding"
    let KeyPrice = "price"
    let KeySeries = "series"
    let KeyPages = "pages"
    let KeyAuthor_info = "author_info"
    let KeySummary = "summary"
    let KeyCatalog = "catalog"
    let KeyEbook_url = "ebook_url"
    let KeyEbook_price = "ebook_price"

    var id = "" //赋值为空的字符串,在任何情况下都不会为 nil , 杜绝nil 错误
    var isbn10 = "" // 老的10位图书编码
    var isbn13 = "" // 新标准的13位图书编码
    var title = ""
    var origin_title = ""
    var alt_title = ""
    var subtitle = ""
    var url = ""
    var alt = ""
    var image = ""
    var images = [String:String]() //key:small , larage , medium
    var author = [String]() //作者是一个字符串数组
    var translator = [String]() //译者姓名
    var publisher = "" //出版社
    var pubdate = "" //出版日期
    var rating = "" //评分
    var tags = [[String:NSObject]]() //字典数组
    var binding = "" //平装 精装
    var price = ""
    var series = [String:String]()
    var pages = "" //总页数
    var author_info = ""
    var summary = "" //摘要
    var catalog = ""// 序言
    var ebook_url = ""
    var ebook_price = ""
    
    
    
    //写一个构造方法解析数据
    init(dict:[String:NSObject]){
        id = dict[KeyId] as? String ?? "" // as? 接卸出来的是一个可选值 , ?? 如果为空 用后面的字符串替换
        isbn10 = dict[KeyIsbn10] as? String ?? ""
        isbn13 = dict[KeyIsbn13] as? String ?? ""
        title = dict[KeyTitle] as? String ?? ""
        origin_title = dict[KeyOrigin_title] as? String ?? ""
        alt_title = dict[KeyAlt_title] as? String ?? ""
        subtitle = dict[KeySubtitle] as? String ?? ""
        url = dict[KeyUrl] as? String ?? ""
        alt = dict[KeyAlt] as? String ?? ""
        image = dict[KeyImage] as? String ?? ""
        images = dict[KeyImages] as? [String:String] ?? [:] //字典
        author = dict[KeyAuthor] as? [String] ?? [] //数组
        translator = dict[KeyTranslator] as? [String] ?? []
        publisher = dict[KeyPublisher] as? String ?? ""
        pubdate = dict[KeyPubdate] as? String ?? ""
        rating = dict[KeyRating] as? String ?? ""
        tags = dict[KeyTags] as? [[String:NSObject]] ?? [] //数组字典
        binding = dict[KeyBinding] as? String ?? ""
        price = dict[KeyPrice] as? String ?? ""
        series = dict[KeySeries] as? [String:String] ?? [:]
        pages = dict[KeyPages] as? String ?? ""
        author_info = dict[KeyAuthor] as? String ?? ""
        summary = dict[KeySummary] as? String ?? ""
        catalog = dict[KeyCatalog] as? String ?? ""
        ebook_url = dict[KeyEbook_url] as? String ?? ""
        ebook_price = dict[KeyEbook_price] as? String ?? ""
    
    }
    
}
