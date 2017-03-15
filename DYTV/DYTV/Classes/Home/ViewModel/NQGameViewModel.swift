//
//  NQGameViewModel.swift
//  DYTV
//
//  Created by djk on 17/3/15.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQGameViewModel: NSObject {
    // MARK:- 懒加载属性
    lazy var games : [NQGameModel] = [NQGameModel]()
}

// MARK:- 发送网络请求
extension  NQGameViewModel{
    func loadAllGameData(finishedCallback: @escaping ()->()){
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.字典转模型
            for dict in dataArray{
                self.games.append(NQGameModel(dict: dict))
            }
            
            //3.完成回调
            finishedCallback()
        }
    }
}
