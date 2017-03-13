//
//  NQRecommendViewModel.swift
//  DYTV
//
//  Created by djk on 17/3/13.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQRecommendViewModel: NQBaseViewModel {
    // MARK:- 懒加载属性
    lazy var cycleModels : [NQCycleModel] = [NQCycleModel]()
    fileprivate lazy var bigDataGroup : NQAnchorGroup = NQAnchorGroup()
    fileprivate lazy var prettyGroup : NQAnchorGroup = NQAnchorGroup()
}

// MARK:- 发送网络请求
extension NQRecommendViewModel{
    // 请求推荐数据
    func requestData(_ finishCallback : @escaping ()->()){
        // 1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        //2.创建Group
        let dGroup = DispatchGroup()
        
        //3.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            //1.获取字典数组
            guard let resultDict = result as? [String : NSObject] else{ return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{ return }
            
            //2.转模型
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //3.获取主播数据
            for dict in dataArray{
                let anchor = NQAnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 4.离开组
            dGroup.leave()
        }
        
        //4.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //1.获取字典数组
            guard let resultDict = result as? [String : NSObject] else{ return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{ return }
            
            //2.转模型
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //3.获取主播数据
            for dict in dataArray{
                let anchor = NQAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 4.离开组
            dGroup.leave()
        }
        
        //5.请求2-12部分游戏数据
        dGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { 
            dGroup.leave()
        }
        
        //6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    // 请求无线轮播的数据
    func requestCycleData(_ finishCallback : @escaping ()->()){
        NetworkTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //1.获取字典数组
            guard let resultDict = result as? [String : NSObject] else{ return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{ return }
//            print(dataArray)
            //2.转模型
            for dict in dataArray{
                self.cycleModels.append(NQCycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}
