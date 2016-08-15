//
//  AppDelegate.swift
//  JsonPairseSwift
//
//  Created by 郑敏 on 16/5/18.
//  Copyright © 2016年 郑敏. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        
        let manager = NSFileManager()
        let enumerator = manager.enumeratorAtPath("/Users/zhengmin/Documents/miaoqu_hl/2版素材/v2/切图/会话窗口/emoji/tiny_压缩图/")
        
        
        var arr = [(Int, String, String)]()
        
        while  let x = enumerator?.nextObject() {
            
            let name = x.pathComponents.last ?? ""
            if name.hasSuffix("@3x.png") {
                continue
            }
            var index = 0
            
            var lenth = 0
            if Int((name as NSString).substringWithRange(NSMakeRange(0, 1))) > 0 {
                lenth = 1
                index = Int((name as NSString).substringWithRange(NSMakeRange(0, 1)))!
            }
            if Int((name as NSString).substringWithRange(NSMakeRange(0, 2))) > 0 {
                lenth = 2
                index = Int((name as NSString).substringWithRange(NSMakeRange(0, 2)))!
            }
            
            if index > 0 {
                let rename = (name as NSString).substringWithRange(NSMakeRange(lenth, name.characters.count - lenth)).componentsSeparatedByString("@").first ?? ""
                arr.append((index, rename, name))
            }
        }
        
        for n in arr {
            try! manager.moveItemAtPath("/Users/zhengmin/Documents/miaoqu_hl/2版素材/v2/切图/会话窗口/emoji/tiny_压缩图/" + n.2, toPath: "/Users/zhengmin/Documents/miaoqu_hl/2版素材/v2/切图/会话窗口/emoji/" + n.1)
        }
        
        let sort = arr.sort { (fi, se) -> Bool in
            return fi.0 < se.0
        }
        let arr2 = sort.map { $0.1 }
        print(arr2)
        
        
        print(sort)
        
        

        
//        let name = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("Profession.plist", ofType: nil)!)
//
//        var arr = [String: [String]]()
//        for dict in name as! [NSDictionary] {
//            let name = dict["groupName"] as! String
//            let list = dict["groupList"] as! [String]
//            
//            arr[name] = list
//        }
//        
//        (arr as NSDictionary).writeToFile("/Users/zhengmin/Documents/hah.plist", atomically: true)
        
        
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

