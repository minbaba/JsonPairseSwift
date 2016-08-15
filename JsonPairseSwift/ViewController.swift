//
//  ViewController.swift
//  JsonPairseSwift
//
//  Created by 郑敏 on 16/5/18.
//  Copyright © 2016年 郑敏. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa
import SwiftyJSON

class ViewController: NSViewController {
    
    
    @IBOutlet var inputText: NSTextView!
    @IBOutlet var outputText: NSTextView!
    var rx_mq_text = PublishSubject<String>()
    let disposebag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.rx_mq_text
            .distinctUntilChanged()
            .subscribeNext {[weak self] (str) in
                
                
                print(str)
                
                let obj = JSON(data: str.dataUsingEncoding(NSUTF8StringEncoding)!)
                
                var str = ""
                if obj.type == .Dictionary {
                
                    for (key, value) in obj.dictionary! {
                        
                        str += ("dynamic var " + key + " = ")
                        switch value.type {
                            
                        case .Number:
                            
                            str += value.stringValue
                            
                            break
                        case .String:
                            
                            str += "\"" + value.stringValue + "\""
                            
                            break
                        case .Bool:
                            
                            str += value.stringValue
                            
                            break
                        case .Array:
                            str += "List<>()"
                            break
                        case .Dictionary:
                            
                            break
                        default:
                            
                            break
                        }
                        
                        str += "\n\n"
                    }
                
                }
                
                
                
                self?.outputText.string = str
                
            }.addDisposableTo(disposebag)


        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
            
            while (true) {
                
                if let str = self.inputText.string {
                    self.rx_mq_text.onNext(str)
                }
                
                sleep(1)
            }
            
            
        }
        
    
        
    
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

