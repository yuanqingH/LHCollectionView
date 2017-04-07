//
//  LHCollectionReusableView.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

open class LHCollectionReusableView: UICollectionReusableView {
    final var _object : LHBaseItem?
    final public var item : LHBaseItem?{
        get {
            return _object
        }
    }
    
    //override
    open func setObject (_ obj:LHBaseItem) -> Void {
        _object = obj
    }
    
    //override
    open class func lhIdentifier() -> String{
        return "\(self)"
    }
    
    //override
    open class func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForObject object: LHBaseItem) -> CGSize{
        return object.size
    }
    
    open class func register(for collectionView:UICollectionView, kind:String)  {
        collectionView.register(self, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.lhIdentifier());
    }
}
