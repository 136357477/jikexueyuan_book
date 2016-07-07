//
//  PhotoBrowserCell.swift
//  Book
//
//  Created by guohui on 16/7/5.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class PhotoBrowserCell: UICollectionViewCell,UIScrollViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    /**
     让 imageView 可以在 scrollView 中滚动
     
     - parameter scrollView: <#scrollView description#>
     
     - returns: <#return value description#>
     */
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
         return imageView //返回 imageView 并且缩放
    }

}
