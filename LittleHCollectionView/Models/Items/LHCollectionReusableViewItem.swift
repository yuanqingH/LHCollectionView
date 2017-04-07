//
//  LHCollectionReusableViewItem.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit
public enum LHCollectionReusableViewKind:String{
    case header = "UICollectionElementKindSectionHeader"
    case footer = "UICollectionElementKindSectionFooter"
}
open class LHCollectionReusableViewItem: LHBaseItem {
    //返回item对应的Type
    open func mapReusableViewType() -> LHCollectionReusableView.Type{
        return LHCollectionReusableView.self
    }
    open var sectionIndex : Int = 0
    open var kind : LHCollectionReusableViewKind = .footer
    open var isHidden : Bool = false
    
    public override init() {
        super.init()
    }
}
