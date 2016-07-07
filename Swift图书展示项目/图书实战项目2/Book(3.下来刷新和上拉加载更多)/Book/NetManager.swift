//
//  NetManager.swift
//  Book
//
//  Created by guohui on 16/6/14.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import Toast //toast 与 mbprogress 不一样 , toast 是一种轻提示 ,不阻塞用户操作
//结构体
struct NetManager {
    
    static let netError = "网络异常,请检查网络"
    
    static func GET(URLString:String,parameters:[String:NSObject]?,showHUD:Bool = true,success:((NSObject?) -> Void)?,failure:((NSError) -> Void)?){
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10 //超时时间
        let mainWindow = UIApplication.sharedApplication().delegate?.window! //使用系统的主 window
        
        if showHUD {
            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true)
        }
        manager.GET(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD{
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
            }
            dispatch_async(dispatch_get_main_queue(), {
                success!(responseObject as? NSObject) //? 如果传过的闭包为nill ,不会崩溃,不执行任何操作
            })
            }) { (task, error)-> Void in
                if showHUD{
                    MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                    mainWindow?.makeToast(netError)
                }
                failure?(error) //执行错误的闭包
        }
        
        
    }
    
    
    
    static func POST(URLString:String,parameters:[String:NSObject]?,showHUD:Bool = true,success:((NSObject?) -> Void)?,failure:((NSError) -> Void)?){
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10 //超时时间
        let mainWindow = UIApplication.sharedApplication().delegate?.window! //使用系统的主 window
        
        if showHUD {
            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true)
        }
        manager.POST(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD{
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
            }
            success!(responseObject as? NSObject) //? 如果传过的闭包为nill ,不会崩溃,不执行任何操作
        }) { (task, error)-> Void in
            if showHUD{
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                mainWindow?.makeToast(netError)
            }
            failure?(error) //执行错误的闭包
        }
        
        
    }
    
    
    
    
    
    
    
}
