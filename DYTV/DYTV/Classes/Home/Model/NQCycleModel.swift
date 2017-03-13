//
//  NQCycleModel.swift
//  DYTV
//
//  Created by djk on 17/3/13.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQCycleModel: NSObject {
    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    // 主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else  { return }
            anchor = NQAnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor : NQAnchorModel?
    
    // MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
