//
//  NQBaseViewModel.swift
//  DYTV
//
//  Created by djk on 17/3/13.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQBaseViewModel: NSObject {
    // MARK:- 定义属性
    ///主播组数据源
    lazy var anchorGroups : [NQAnchorGroup] = [NQAnchorGroup]()
}

// MARK:- 发送网络请求
extension NQBaseViewModel{
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping ()->()){
        NetworkTools.requestData(type: .get, URLString: URLString) { (result) in
            //1.对界面进行处理
            guard let resultDict = result as? [String : Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else{ return }
            
            //2.判断是否是分组数据
            if isGroupData{
                for dict in dataArray{
                    self.anchorGroups.append(NQAnchorGroup(dict: dict))
                }
            }else{
                let group = NQAnchorGroup()
                for dict in dataArray{
                    group.anchors.append(NQAnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            
            //3.完成回调
            finishedCallback()
        }
    }
}
