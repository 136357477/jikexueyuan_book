//
//  BookViewController.swift
//  Book
//
//  Created by guohui on 16/6/14.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    let KeyBooks = "books"
    let URLString = "https://api.douban.com/v2/book/search"
    var tag = "Swift"
    var books = [Book]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetManager.GET(URLString, parameters: ["tag" : tag,"start":0,"count":10], success: { (responseObject) in
//            print(responseObject)
            self.books = [] //block 中必须写 self 提醒你可能会循环引用
            if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]]{
                for dict in array{
                    self.books.append(Book(dict: dict))
                }
                print(self.books.count)
            }
            
            }) { (error) in
                print(error)
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

