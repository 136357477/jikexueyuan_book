//
//  RatingView.swift
//  Book
//
//  Created by guohui on 16/6/22.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
//评分控件
class RatingView: UIView {
    var StarMax = 5.0 //最大评分
    var StarHeight = 22.0 //星星高度
    var StarSpace = 4.0 //默认间距
    var emptyImageViews = [UIImageView]() //5个空白星星组成的数组
    var fillImageViews = [UIImageView]() //金色星星
    //当前评分
    var value = 0.0 { //添加一个属性观察 来更新 UI
        didSet{
            if value > StarMax {
                value = StarMax
            }else if value < 0{
                value = 0
            }
            /**
             *  更新 UI
             *
             *  @param i         提取 i 在方法中可以直接用
             *  @param imageView <#imageView description#>
             *
             *  @return <#return value description#>
             */
            for (i,imageView) in fillImageViews.enumerate() {
                 let i = Double(i) //i 转为 double 便于计算
                if value >= i + 1 {
                    //完整的显示 填充图片
                    imageView.hidden = false
                    imageView.layer.mask = nil
                }else if value > i && value < i + 1{
                    //既不是完整的填充图片也不是空的图片 是带一个百分比的, 构造一个带懵层的
                    let maskLayer = CALayer()
                    maskLayer.frame = CGRect(x: 0, y: 0, width: (value - i) * StarHeight, height: StarHeight)
                    maskLayer.backgroundColor = UIColor.blackColor().CGColor //设一个背景颜色
                    imageView.layer.mask = maskLayer
                    imageView.hidden = false
                    
                }else{
                    //完整的隐藏填充图片
                    imageView.hidden = true
                    imageView.layer.mask = nil
                }
            }
            
        }
    
    }
    
    
    
    
    //类函数 静态函数
    static var KeyNoRating = "KeyNoRating"
    //没有评分时:
    static func showNoRating(view:UIView){
        for subview in view.subviews {
            if let subview = subview as? RatingView {
                //如果 view 中存在评分控件,先把评分控件隐藏起来
                subview.hidden = true
            }
        }
        //使用 lable 之前判断
        var label:UILabel! = objc_getAssociatedObject(view, &KeyNoRating) as? UILabel
        //如果找不到这个 lab 才创建这个 lab
        if label == nil {
            let label = UILabel(frame:view.bounds)
            label.font = UIFont.systemFontOfSize(13)
            view.addSubview(label)
            label.text = "暂无评分"
            /**
             使用 OC 这个库给设置一个关联的属性
             - parameter <Tobject: 添加的 view
             - parameter <Tkey:     关联的属性
             - parameter <Tvalue:  <#<Tvalue description#>
             - parameter <Tpolicy: <#<Tpolicy description#>
             */
            objc_setAssociatedObject(view, KeyNoRating, label, .OBJC_ASSOCIATION_ASSIGN)
            label.hidden = false
        }
        

        
        
    }
    
    /**
     编写供外界调用的 通常用静态函数的 类名 + . 调用
     
     - parameter view:  显示在哪个 View 中
     - parameter value: 评分的值
     - parameter max:   最大值, 默认为5
     */
    static func showInView(view:UIView,value:Double,StarMax:Double = 5){
        //TODO:cell 每次重用的时候都会调用,是一个 bug, 重复添加这个空间
        for subView in view.subviews{
            if let subView = subView as? RatingView {
                subView.value = value
                return
            }
        }
        
        //初始化
        let ratingView = RatingView(StarHeight: Double(view.frame.size.height), StarMax: StarMax) //调用自己写的构造函数
        ratingView.hidden = false
        view.addSubview(ratingView) //把评分控件传到 View 中
        ratingView.value = value //把 value 赋给评分的 value 这个是功能的重心
        //如果找到这个 label 隐藏这个 label
        if let label = objc_getAssociatedObject(view, &KeyNoRating) as? UILabel{
            label.hidden = true
        }
        
   
    }

    /**
     构造函数 构造 ratingview指定构造器
     
     - parameter StarHeight: 评分高度
     - parameter StarMax:    评分星星数
     
     - returns: <#return value description#>
     */
    init(StarHeight:Double,StarMax:Double) {
         self.StarHeight = StarHeight //self 表示属于这个类的,没加 self 属于外界调用传进来的参数
        self.StarMax = StarMax
        self.StarSpace = StarHeight * 0.15 //星星的间距
        let frame = CGRect(x: 0, y: 0, width: StarHeight * StarMax + StarSpace * (StarMax - 1), height: StarHeight) //构造评分控件的 frame
        super.init(frame: frame) //调用 super 的 init 的 frame
        
        //构造空的一排星星和点亮的一排星星
        for i in 0...Int(StarMax - 1) { //float 没法循环遍历 转化为 int
            let i = Double(i) //取到单独的元素 再转为 double ,便于运算
            //每次循环构造空的 imageview 
            let emptyImageView = UIImageView(image:UIImage(named: "star_empty"))
            let fillImageView = UIImageView(image: UIImage(named: "star_fill")) //填充图片
            let frame = CGRect(x: StarHeight * i + StarSpace * i, y: 0, width: StarHeight, height: StarHeight)
            emptyImageView.frame = frame
            fillImageView.frame = frame
            emptyImageViews.append(emptyImageView)
            fillImageViews.append(fillImageView)
            addSubview(emptyImageView)
            addSubview(fillImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
