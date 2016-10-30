//
//  AnchorModel.swift
//  DYZB
//
//  Created by apple on 2016/10/29.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    var room_id : Int = 0
    var isVertical : Int = 0
    var online : Int = 0
    var vertical_src :String = ""
    var room_name :String = ""
    var nickname :String = ""
    var anchor_city :String = ""
    
    init(_ dict : [String :NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String){}
    
}
