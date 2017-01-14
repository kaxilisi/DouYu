//
//  CycleModel.swift
//  DYZB
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    var title : String = ""
    var pic_url :String = ""
    
    var room :[String :NSObject ]?{
        didSet {
            guard let room  = room else {return}
            anchor = AnchorModel(room)
        }
    
    }
    var anchor : AnchorModel?
    
    init(_ dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
