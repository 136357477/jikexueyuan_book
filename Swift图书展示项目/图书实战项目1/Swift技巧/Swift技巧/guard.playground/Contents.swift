//: Playground - noun: a place where people can play

import UIKit

//guard 相当于if 但是比if强大
func checkup(person:[String:String]){
    //检查身份证,如果身份证没带,则不能进入考场
    guard let id = person["id"] else {
        print("没有身份证不能进入考场")
        return
    }
    //检查准考证,如果准考证没带,则不能进入考场
    guard let examNumber = person["examNumber"] else {
        print("没有准考证,不能进入考场!")
        return
    }
    
    //身份证和准考证齐全,方可进入考场
    print("你的身份证号为:\(id),准考证号为:\(examNumber),请进入考场!")
    
}

//checkup(["id":"123456"])
//checkup(["examNumber":"2423423"])
checkup(["id":"12345","examNumber":"5431"])



