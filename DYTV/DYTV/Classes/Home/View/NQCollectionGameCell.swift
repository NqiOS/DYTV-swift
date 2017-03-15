//
//  NQCollectionGameCell.swift
//  DYTV
//
//  Created by djk on 17/3/14.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQCollectionGameCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
    
    // MARK: 定义模型属性
    var gameModel : NQBaseModel? {
        didSet {
            titleLabel.text = gameModel?.tag_name
            
            if let iconURL = URL(string: gameModel?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }

}
