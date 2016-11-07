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
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list else {return}
                for dict in room_list {
                    anchors.append(AnchorModel(dict))
            }
        }
    }
    /// 组显示标题
    var tag_name : String = ""
    /// 组显示图标
    var icon_name : String = "home_header_normal"
    ///模型对象数据
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    var push_vertical_screen : String = ""
    
    override init(){
        
    }
    
    init(_ dict : [String :NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String){}

}
