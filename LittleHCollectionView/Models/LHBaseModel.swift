//
//  LHBaseModel.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

open class LHBaseModel{
    open var items : [Any]
    open var sections : [LHCollectionReusableViewItem]
    open var pageSize : Int = 20
    open var pageNumber : Int = 1
    open var loading : Bool = false
    open var hasNext : Bool = false
    
    open var pageSourceType : String?
    open var listVersion : String?
    
    open var visibleRect : CGRect?
    
    public init() {
        self.items = []
        self.sections = []
    }
    
    open func loadItems(_ parameters : [String:Any]? = nil,
                        completion : @escaping ([String:Any]?)->Void ,
                        failure : @escaping (Error)->Void){
        
    }
}
