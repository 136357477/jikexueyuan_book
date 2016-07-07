//: Playground - noun: a place where people can play

import UIKit

 /*
   map:得到一个有闭包里面的返回值组成的新序列
   flatMap:与map类似的功能,但是会过滤掉返回值里的nil值
   Filter:得到一个有弊表返回值为true的值组成的新序列
 **/

[1,2,3,4,5]

var result = [1,2,3,4,5].map{$0 * 2}
result

//var images = (1...7).map{UIImage(named:"image\($0).png")}
/// flatMap 会把闭包中nil的值过滤掉 map 不过滤
var images = (1...7).flatMap{UIImage(named:"image\($0).png")}
images.count

images

result = [1,2,3,4,5].filter{$0>2}

result





