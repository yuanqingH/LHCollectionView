//
//  LHDemoRootTypeTwoCell.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHDemoRootTypeTwoCell: LHCollectionViewCell {
    var typeTwoView : LHDemoRootTypeTwoView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView(){
        let tView = Bundle.main.loadNibNamed("LHDemoRootTypeTwoView", owner: self, options: nil)?.last as?LHDemoRootTypeTwoView
        if let aView = tView{
            self.addSubview(aView)
            self.typeTwoView = tView
        }
    }
    
    
    override func setObject(_ obj: LHBaseItem) {
        super.setObject(obj)
        if obj is LHDemoRootTypeTwoItem{
            let tItem = obj as! LHDemoRootTypeTwoItem
            self.typeTwoView?.setItem(item: tItem)
            self.typeTwoView?.frame = CGRect.init(origin: .zero, size: tItem.size)
        }
    }
    
}
