//
//  BookExtensions.swift
//  Book
//
//  Created by guohui on 16/6/14.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
import SDWebImage

// 工程中的 所有扩展均写在此处
extension UIImage {
    /**
     把一个 image 转化为 这个 size大小的图片
     - parameter size: 要转化的大小
     */
    func resizeToSize(size:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0) //开始一个上下文
        drawInRect(CGRectMake(0, 0,  size.width, size.height)) //开始绘制  把图片调整一个 size
        let newImage = UIGraphicsGetImageFromCurrentImageContext() //从上下文中得到调整后的图片
        UIGraphicsEndImageContext() //关闭上下文
        return newImage
    }
}


extension UIImageView{
    /**
     UIImageView 的扩展
     - parameter URLString: 网络请求图片的 URL
     - parameter width:      图片的宽度
     - returns: <#return value description#>
     */
    func setResizeImageWith(URLString:String,width:CGFloat) {
        let URL = NSURL(string: URLString) //构造 url 对象
        let key = SDWebImageManager.sharedManager().cacheKeyForURL(URL) ?? "" //sharedManager 从 sdwebimage 中取得缓存 取得缓存的 key
        if var cacheImage = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(key){
            //使用缓存图片
            if cacheImage.size.width > width {
                //计算 需要的 宽度高度
                let size = CGSizeMake(width, cacheImage.size.height * (width/cacheImage.size.width))
                cacheImage = cacheImage.resizeToSize(size)
            }
            self.image = cacheImage
        }else{
            
            /**
             *  没有缓存 就手动 下载图片
             *
             *  @param URL                          下载的路径
             *  @param .AllowInvalidSSLCertificates <#.AllowInvalidSSLCertificates description#>
             *  @param nil                          进度 不需要
             *  @param UIImage!                     回调 图片
             *  @param NSData!                      回调 数据
             *  @param NSError!                     <#NSError! description#>
             *  @param Bool                         <#Bool description#>
             *
             *  @return <#return value description#>
             */
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(URL, options: .AllowInvalidSSLCertificates, progress: nil, completed: { (var image, data, error, result) in
                if image != nil && image.size.width > width {
                    let size = CGSizeMake(width, image.size.height * (width/image.size.width))
                    image = image.resizeToSize(size)
                }
                self.image = image
            }) //sdwebimage 默认的下载方法
            
        }
        
    }
}