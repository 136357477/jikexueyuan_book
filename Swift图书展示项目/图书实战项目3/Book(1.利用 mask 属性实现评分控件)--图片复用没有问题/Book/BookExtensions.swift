//
//  BookExtensions.swift
//  Book
//
//  Created by guohui on 16/2/17.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
import SDWebImage

//所有的扩展方法都写在这里
extension UIImage{
    //对UIImage 进行扩展 传入一个size 返回这个size大小的Image
    func resizeToSize(size:CGSize)->UIImage{
    UIGraphicsBeginImageContextWithOptions(size, false, 0) //在这个上下文中调整这个图片
        drawInRect(CGRectMake(0, 0, size.width, size.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext() //得到调整后的图片
        UIGraphicsEndImageContext() //关闭上下文
        return newImage
    }
}

extension UIImageView{
    func setResizeImageWith(URLString:String,width:CGFloat){
        let URL = NSURL(string: URLString)
        let key = SDWebImageManager.sharedManager().cacheKeyForURL(URL) ?? ""
        if var cacheImage = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(key){
            //有缓存
            if cacheImage.size.width > width{
                let size = CGSizeMake(width, cacheImage.size.height*(width/cacheImage.size.width))
                cacheImage = cacheImage.resizeToSize(size)
            }
            self.image = cacheImage
            
        }else{
            //没有缓存
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(URL, options: .AllowInvalidSSLCertificates, progress: nil, completed: { (var image, data , error , result ) -> Void in
                if image != nil && image.size.width > width{
                    let size = CGSizeMake(width, image.size.height*(width/image.size.width))
                    image = image.resizeToSize(size)
                }
                self.image = image 
            })
            
            
        }
    }
}