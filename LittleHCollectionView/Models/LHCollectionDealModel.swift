//
//  LHDealModel.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHCollectionDealModel: LHBaseModel {
    var loadMoreItem = LHCollectionLoadMoreItem()
    
    ///加载更多的时候调用
    ///
    /// - parameter  needLoadItem : 闭包调用controller的loadItems
    open func loadMore(_ needLoadItem:()->Void){
        var sectionIndex = self.getSectionCount() - 1
        sectionIndex = sectionIndex<0 ? 0 : sectionIndex
        
        self.loadMoreItem.sectionIndex = sectionIndex
        
        if !self.hasNext {
            self.loadMoreItem.hasNext = false
            self.loadMoreItem.loading = false
            self.loadMoreItem.failed = false
            
            //这里loaditem
            needLoadItem()
            return
        }
        
        if self.loading {
            return
        }
        
        self.loadMoreItem.hasNext = self.hasNext
        self.loadMoreItem.loading = true
        self.loadMoreItem.failed = false
        self.loadMoreItem.text = "努力加载中..."
        
        self.loading = true
        self.pageNumber += 1
        
        //这里loaditem
        needLoadItem()
    }
    
    ///reloadData之前更新loadmore
    ///
    open func resetLoadState(){
        self.removeLoadMoreItem()
        var sectionIndex = self.getSectionCount() - 1
        sectionIndex = sectionIndex<0 ? 0 : sectionIndex
        
        self.loadMoreItem.sectionIndex = sectionIndex
        
        self.sections.append(self.loadMoreItem)
        
        //如果有footerview占用了loadmoreview。优先展示loadmoreview
        let _ = self.sections.map { (item) in
            item.isHidden = false
            if !(item is LHCollectionLoadMoreItem) && item.sectionIndex == sectionIndex && item.kind == .footer{
                item.isHidden = true
            }
        }
    }
    
    
    ///设置有数据加载下一页失败
    ///
    open func resetLoadMoreState(){
        var sectionIndex = self.getSectionCount() - 1
        sectionIndex = sectionIndex<0 ? 0 : sectionIndex
        
        self.pageNumber -= 1
        if self.pageNumber < 1 {
            self.pageNumber = 1
        }
        
        self.loadMoreItem.sectionIndex = sectionIndex
        self.loadMoreItem.loading = false
        self.loadMoreItem.hasNext = true
        self.loadMoreItem.failed = true
        self.loadMoreItem.text = "加载失败，点击重新加载"
    }
    
    func getSectionCount() -> Int{
        for element in self.items{
            guard element is [LHBaseItem] else {
                return 1
            }
        }
        
        return self.items.count
    }
    
    func removeLoadMoreItem(){
        var newSections : [LHCollectionReusableViewItem] = []
        
        for item in self.sections{
            if item is LHCollectionLoadMoreItem {
                continue
            }
            newSections.append(item)
        }
        
        self.sections = newSections
        
    }
}
