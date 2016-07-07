//
//  NetManager.swift
//  Book
//
//  Created by guohui on 16/2/17.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import Toast

struct NetManager {
    static let netError = "网络异常,请检查网络"
    static let KeyBooks = "books"
    static let URLStringBooks = "https://api.douban.com/v2/book/search"
    static let pageSize = 10
    /**
     获取图书 title 列表
     
     - parameter tag:           <#tag description#>
     - parameter fields:          每一本数只需要 title 字段 ,服务器只返回title
     - parameter resultClosure: 返回 字符串数组 , 不需要判断成功与否 ,只有成功才执行这个闭包
     */
    static func getBooksTitles(tag:String,page:Int,resultClosure:([String])->Void){
        NetManager.GET(URLStringBooks, parameters: ["tag":tag,"start":page * pageSize,"count":pageSize,"fields":"title"],showHUD: false, success: { (responseObject) -> Void in
            var searchTitles = [String]()
            if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]]{
                for dict in array {
                    //将字典里的 title 转化为字符串
                    if let title = dict["title"] as? String{
                        searchTitles.append(title)
                    }
                }
            }
            //本来 AFNetWorking 就会把返回数据放到主线程里 dispatch_async(dispatch_get_main_queue(), { () -> Void in 可省略
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                resultClosure(searchTitles) //返回参数闭包 , true 表示成功 , books 是返回数据

            })
            
            //            resultClosure(true,books)
        }) { (error ) -> Void in
            print(error)
        }
    }
    
    
    /**
     优化的网络封装
     - parameter tag:           <#tag description#>
     - parameter page:          <#page description#>
     - parameter resultClosure: 服务器网络请求结果的闭包 参数是 bool 表示成功与否,隐试解析可选数组
     */
    static func getBooks(tag:String,page:Int,resultClosure:(Bool,[Book]!)->Void){
        NetManager.GET(URLStringBooks, parameters: ["tag":tag,"start":page * pageSize,"count":pageSize],showHUD: false, success: { (responseObject) -> Void in
            var books = [Book]()
            if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]]{
                for dict in array {
                    books.append(Book(dict: dict)) //
                }
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                resultClosure(true,books)
            })
            
//            resultClosure(true,books)
            }) { (error ) -> Void in
                print(error)
//                resultClosure(false,nil)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    resultClosure(false,nil)
                })
        }
     }
    

    static func GET(URLString:String,parameters:[String:NSObject]?,showHUD:Bool = true,success:((NSObject?)->Void)?,failure:((NSError)->Void)?){
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10 // 超时时间
        
        let mainWindow = UIApplication.sharedApplication().delegate!.window! //系统的主Window
        
        if showHUD{
            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true) //淡入淡出的动画
        }
        
        manager.GET(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD{
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                
            }
            success?(responseObject as? NSObject)
            }) { (task , error ) -> Void in
                if showHUD{
                    MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                    mainWindow?.makeToast(netError)
                }
                failure?(error)
        }
    }
    
    
    static func POST(URLString:String,parameters:[String:NSObject]?,showHUD:Bool = true,success:((NSObject?)->Void)?,failure:((NSError)->Void)?){
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10 // 超时时间
        
        let mainWindow = UIApplication.sharedApplication().delegate!.window! //系统的主Window
        
        if showHUD{
            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true) //淡入淡出的动画
        }
        
        manager.POST(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD{
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                
            }
            success?(responseObject as? NSObject)
            }) { (task , error ) -> Void in
                if showHUD{
                    MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                    mainWindow?.makeToast(netError)
                }
                failure?(error)
        }
    }
}
