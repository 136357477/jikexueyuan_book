//: Playground - noun: a place where people can play

import UIKit

class TestObject{
     // static 属于这个类 而不属于这个对象
    // private  外界无法访问
    private static let testObject = TestObject()
    //外界访问单利的属性,外界只能通过 单利访问,不能自己构造 (构造函数改为私有)
    static var shareInstance:TestObject{
        return testObject
    }
    //构造函数改为私有
    private init(){
    
    }
    
}