//
//  NADate-Extension.swift
//  DYZB
//
//  Created by apple on 2016/10/27.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() ->String{
        
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }

}
