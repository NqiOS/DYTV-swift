//
//  NQAmuseViewModel.swift
//  DYTV
//
//  Created by djk on 17/3/15.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQAmuseViewModel: NQBaseViewModel {

}

// MARK:- 发送网络请求
extension NQAmuseViewModel{
    func loadAmuseData(finishedCallback:@escaping ()->()){
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
