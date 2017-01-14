//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by apple on 2016/10/29.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class RecommendViewModel{
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//MARK:- 发送网络请求
extension RecommendViewModel{
    func requestData(_ finishCallback : @escaping () -> ()){
        let parameters = ["limit" : "4","offset":"0","time" : NSDate.getCurrentTime()]
        //第一部分数据
        
        let dGroup = DispatchGroup()
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": NSDate.getCurrentTime()]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            self.bigDataGroup.tag_name = "热门"
            
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict  in dataArray{
                let anchor = AnchorModel(dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        //第二部分数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            
            self.prettyGroup.tag_name = "颜值"
            
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict  in dataArray{
                let anchor = AnchorModel(dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        //第三部分数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            for dict in dataArray{
                let group = AnchorGroup(dict)
                if group.push_vertical_screen == "0"{
                    self.anchorGroups.append(group)
                }
            }
            dGroup.leave()
        }
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    func requestCycleData(_ finishCallback : @escaping () -> ()){
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version" : "2.401"]){ (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //字典转模型
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict))
            }
            
            finishCallback()
            
        }

        
        }
    }

