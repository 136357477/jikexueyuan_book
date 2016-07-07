//: Playground - noun: a place where people can play

import UIKit

let MaxValue = 999
let MinValue = -999
var number = 0 {
    //添加属性观察的代码
    willSet { //设置之前会调用
        print("将从\(number)变成\(newValue)")
        //在willSet 中 newValue 获取新赋的值
    }
    didSet {
        if number > MaxValue{
            number = MaxValue
        }else if number < MinValue {
            number = MinValue
        }
        print("已经从\(oldValue)变成\(number)")
        //在didSet 中 oldValue 获取原有的值
    }
}

number = 1000

number