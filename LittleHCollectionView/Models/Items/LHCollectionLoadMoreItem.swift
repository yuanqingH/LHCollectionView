//
//  LHCollectionLoadMoreItem.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

open class LHCollectionLoadMoreItem: LHCollectionReusableViewItem {
    open var text: String?
    open var loading: Bool =  false
    open var failed: Bool = false
    open var hasNext: Bool = false

    open override func mapReusableViewType() -> LHCollectionReusableView.Type {
        return LHCollectionLoadMoreView.self
    }
    
    
    public override init() {
        super.init()
        self.size = CGSize.init(width: UIScreen.main.bounds.width, height: 44)
    }
}
