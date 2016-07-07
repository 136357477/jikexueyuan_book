//
//  PhotoBrowser.swift
//  Book
//
//  Created by guohui on 16/6/29.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
import SnapKit


class PhotoBrowser: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    let KeyPhotoBrowserCell = "PhotoBrowserCell"
    
    
    var imageView:UIImageView!
    var URLStrings = [String]()
    
    
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    
    /**
     编写图片浏览器调用的方法  用类方法(static) 方便外部调用
     
     - parameter imageView:  主要是做动画用,通过 imageView 定位打开浏览器的初始位置
     - parameter URLStrings: 存放每张图片的网络地址
     - parameter index:      图片浏览器打开的一瞬间定位到多少页
     */
    static func showFromImageView(imageView:UIImageView,URLStrings:[String],index:Int) -> PhotoBrowser{
        let browser = NSBundle.mainBundle().loadNibNamed("PhotoBrowser", owner: nil, options: nil)[0] as! PhotoBrowser
        browser.imageView = imageView
        browser.animateImage(index)
        return browser
    }
    /**
     <#Description#>
     
     - parameter collectionView:       <#collectionView description#>
     - parameter collectionViewLayout: <#collectionViewLayout description#>
     - parameter section:              <#section description#>
     
     - returns: <#return value description#>
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: ScreenWidth, height: ScreenHeight)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return URLStrings.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(KeyPhotoBrowserCell, forIndexPath: indexPath) as! PhotoBrowserCell //强转成自己的 cell
        cell.imageView.sd_setImageWithURL(NSURL(string: URLStrings[indexPath.row]))
        return cell
    }
    
    func colseBrowser()  {
        removeFromSuperview()
    }
    
    func configureBrowser(URLStrings:[String]) {
        collectionView.addGestureRecognizer(UIGestureRecognizer(target: self, action: "colseBrowser"))
        self.URLStrings = URLStrings
        MainWindow.addSubview(self)
        //注册 collectionView
        collectionView.registerNib(UINib(nibName: KeyPhotoBrowserCell, bundle: nil), forCellWithReuseIdentifier: KeyPhotoBrowserCell)
        
        //给浏览器和主 Window添加一个约束
        self.snp_makeConstraints { (make) in
            //闭包内编写约束
            make.edges.equalTo(MainWindow) //四边的边距等于主 Window
        } //使用 SnapKit 框架
        //collectionView 要显示所以里面要注册单元格
        
    }
    static func reloadForScreenRotate(){
        for view in MainWindow.subviews {
            if let view = view as? PhotoBrowser {
                view.reloadForScreenRotate()
            }
        }
    }
    
    
    /**
     处理旋转的方法
     */
    func reloadForScreenRotate() {
        collectionView.reloadData() //先刷新,再设置contentOffset
        collectionView.contentOffset.x = collectionView.contentOffset.x * ScreenRatio
        
    }
    
    
    /**
     做打开时的动画
     
     - parameter index: <#index description#>
     */
    func animateImage(index:Int) {
        
        var startFrame = self.imageView.superview!.convertRect(self.imageView.frame, toView: MainWindow) //点击的 imageView 相对于主 Window的 frame 做动画开始的 frame
        var endFrame = UIScreen.mainScreen().bounds //结束的 frame
        if let image = self.imageView.image{
            let ratio = image.size.width / image.size.height
            if ratio < (startFrame.width / startFrame.height) {//长条图片
                let midx = CGRectGetMidX(startFrame) //得到中间的长条 frame
                startFrame.size.width = startFrame.height * ratio
                startFrame.origin.x = midx - startFrame.size.width / 2 ;
            }else{
                //改变 y 值
                let midY = CGRectGetMidY(startFrame)
                startFrame.size.height = startFrame.width / ratio
                startFrame.origin.y = midY - startFrame.size.height / 2
            }
            /**
             *  小于当前屏幕宽高比
             */
            if ratio < ScreenRatio {
                endFrame.size.width = ScreenHeight * ratio
            }else{
                endFrame.size.height = ScreenWidth / ratio
                endFrame.origin.y = ScreenMidY - endFrame.size.height / 2
            }
            //TODO:动画
            let animateImageView = UIImageView(frame: startFrame) //临时的 imageView
            MainWindow.addSubview(animateImageView)
            animateImageView.image = imageView.image
            animateImageView.contentMode = .ScaleAspectFit
            viewBackground.alpha = 0 //透明度是0
            self.imageView.hidden = true
            /**
             *  <#Description#>
             *
             *  @param duration            动画时长
             *  @param delay               延时
             *  @param options             速度渐渐变快
             *  @param animations          动画 block
             *
             *  @return
             */
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseIn, animations: { 
                    animateImageView.frame = endFrame
                    self.viewBackground.alpha = 1
                }, completion: { (result) in
                    //完成的时候
                    self.imageView.hidden = false
                    self.collectionView.contentOffset = CGPointMake(ScreenWidth * CGFloat(index), 0) //设计 collectionView 初始的 contentOffset 等于 第几个 index * 屏幕的宽度
                    self.collectionView.hidden = false
                    animateImageView.removeFromSuperview() //ba
            })
            
        }//若果 imageView 有图片, 我们要把开始和结束的 frame 按照图片调整,不然会有卡针的现象
        
        
        
    }
}
