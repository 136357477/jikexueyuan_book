//
//  Book.swift
//  Book
//
//  Created by guohui on 16/2/17.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

    struct Book {
        let KeyId = "id"
        let KeyIsbn10 = "isbn10"
        let KeyIsbn13 = "isbn13"
        let KeyTitle = "title"
        let KeyOrigin_title = "origin_title"
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
        
        
        var id = ""
        var isbn10 = "" //老的10位图书编码
        var isbn13 = "" // 新标准的13位图书编码
        var title = ""
        var origin_title = ""
        var subtitle = ""
        var url = ""
        var alt = ""
        var image = ""
        var images = [String:String]() //key :small, larage ,medium
        var author = [String]() //返回的是一个字符串类型的数组
        var translator = [String]() //翻译名
        var publisher = "" //出版社
        var pubdate = "" //出版日期
        var rating : Rating? //评分 可选,评分可能为空
        var tags = [[String:NSObject]]() //字典数组 标签
        var binding = "" //平装
        var price = ""
        var series = [String:String]()
        var pages = "" //总页数
        var author_info = ""
        var summary = "" //摘要
        var catalog = "" //序言
        var ebook_url = ""
        var ebook_price = ""
        
        init(dict:[String:NSObject]){
            id = dict[KeyId] as? String ?? ""
            isbn10 = dict[KeyIsbn10] as? String ?? ""
            isbn13 = dict[KeyIsbn13] as? String ?? ""
            title = dict[KeyTitle] as? String ?? ""
            origin_title = dict[KeyOrigin_title] as? String ?? ""
            subtitle = dict[KeySubtitle] as? String ?? ""
            url = dict[KeyUrl] as? String ?? ""
            alt = dict[KeyAlt] as? String ?? ""
            image = dict[KeyImage] as? String ?? ""
            images = dict[KeyImages] as? [String:String] ?? [:]
            author = dict[KeyAuthor] as? [String] ?? []
            translator = dict[KeyTranslator] as? [String] ?? []
            publisher = dict[KeyPublisher] as? String ?? ""
            pubdate = dict[KeyPubdate] as? String ?? ""
            if let ratingDict = dict[KeyRating] as? [String:NSObject] {
                rating = Rating(dict: ratingDict) //如果字典存在这个元素,并且能够转化为字典,就构造一个评分,否则默认为 nill
            }
//            rating = dict[KeyRating] as? String ?? ""
            tags = dict[KeyTags] as? [[String:NSObject]] ?? []
            binding = dict[KeyBinding] as? String ?? ""
            price = dict[KeyPrice] as? String ?? ""
            series = dict[KeySeries] as? [String:String] ?? [:]
            author_info = dict[KeyAuthor_info] as? String ?? ""
            summary = dict[KeySummary] as? String ?? ""
            catalog = dict[KeyCatalog] as? String ?? ""
            ebook_url = dict[ebook_url] as? String ?? ""
            ebook_price = dict[ebook_price] as? String ?? ""
    }
    
    
}
