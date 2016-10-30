//
//  AnchorGroup.swift
//  DYZB
//
//  Created by apple on 2016/10/28.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 房间信息
    var room_list : [[String : NSObject]]?
    /// 组显示标题
    var tag_name : String = ""
    /// 组显示图标
    var icon_name : String = "home_header_normal"
    
    init(dict : [String :NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String){}
}
