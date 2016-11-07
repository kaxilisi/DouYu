//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by apple on 2016/11/7.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit


class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var OnlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchor :AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            } else{
                onlineStr = "\(anchor.online)在线"
            }
            OnlineBtn.setTitle(onlineStr, for:.normal)
            
            nickNameLabel.text = anchor.nickname
            
            
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
}
