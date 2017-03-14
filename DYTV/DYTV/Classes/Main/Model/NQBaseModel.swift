//
//  NQBaseModel.swift
//  DYTV
//
//  Created by djk on 17/3/14.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQBaseModel: NSObject {
    // MARK:- 定义属性
    //名字
    var tag_name : String = ""
    //图片
    var icon_url : String = ""
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
