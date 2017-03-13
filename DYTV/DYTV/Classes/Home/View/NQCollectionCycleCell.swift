//
//  NQCollectionCycleCell.swift
//  DYTV
//
//  Created by djk on 17/3/13.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQCollectionCycleCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var cycleModel : NQCycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            print(cycleModel?.title)
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
}
