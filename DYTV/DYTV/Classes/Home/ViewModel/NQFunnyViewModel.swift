//
//  NQFunnyViewModel.swift
//  DYTV
//
//  Created by djk on 17/3/16.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQFunnyViewModel: NQBaseViewModel {

}

extension  NQFunnyViewModel{
    func loadFunnyData(finishedCallback:@escaping ()->()){
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
