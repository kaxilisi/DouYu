//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by apple on 2017/1/1.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {


    
    
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var cycleModel :CycleModel?{
        didSet {
            guard let cycleModel = cycleModel else {
                return
            }
            
            titleLabel.text = cycleModel.title
            guard let iconURL = URL(string: cycleModel.pic_url) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
            
        }
    }
    
    
}
