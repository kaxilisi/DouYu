//
//  CollectionNoramlCell.swift
//  DYZB
//
//  Created by apple on 2016/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CollectionNoramlCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
   override var anchor :AnchorModel?{
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
}
