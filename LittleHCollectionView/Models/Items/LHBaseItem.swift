//
//  LHBaseItem.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

open class LHBaseItem {
    //返回item对应的cellType
    open func mapViewType() -> LHCollectionViewCell.Type{
        return LHCollectionViewCell.self
    }
    //计算cell的size 默认是zero
    open var size : CGSize = .zero
    
    public init() {
        
    }
}
