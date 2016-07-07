//: Playground - noun: a place where people can play

import UIKit

extension Int {
    func times(closure: (() -> ())?){ //可选的闭包
        if self >= 0 {
            for _ in 1...self {
                closure?()
            }
        }
    }
}

3.times {print("someting")}

//协议扩展
["key":"value"].description //把字典以字符串形式打印出来

extension CustomStringConvertible{
    var upperDescription : String{
        return self.description.uppercaseString
    }
    
}

["key":"value"].upperDescription //把字典以字符串形式打印出来


