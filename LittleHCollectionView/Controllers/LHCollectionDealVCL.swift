//
//  LHCollectionDealVCL.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHCollectionDealVCL: LHCollectionVCL,LHCollectionLoadMoreViewDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
    }
    
    open func resetLoadMoreState(){
        let model = self.model as? LHCollectionDealModel
        model?.resetLoadMoreState()
        self.reloadData()
    }
    
    open func loadMore(){
        let model = self.model as? LHCollectionDealModel
        model?.loadMore {
            [unowned self] in
            self.reloadData()
            if self.model.hasNext{
                self.loadItems()
            }
        }
    }
    
    ///这个方法在reloadData之前调用 刷新loadmore
    open func resetLoadState(){
        let model = self.model as? LHCollectionDealModel
        model?.resetLoadState()
    }
    
    
    
    ///MARK: 预加载方法
    open func preLoadMore(){
        if self.previousOffset.y < 1 || self.model.loading{
            return
        }
        
        if self.verticalDirection == .up {
            self.loadMore()
        }
    }
    
    open func reloadData(){
        
    }
    
    
    ///MARK: -
    open override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if view is LHCollectionLoadMoreView{
            let loadMoreView = view as! LHCollectionLoadMoreView
            loadMoreView.delegate = self
        }
    }
    
    ///MARK: - TBBZCollectionLoadMoreViewDelegate
    open func didTapLoadMoreView(_ loadMoreView : LHCollectionLoadMoreView){
        self.loadMore()
    }
    
    ///MARK: - RegisterClass
    override open func registerClass() {
        super.registerClass()
        if let collection =  self.collectionView {
            LHCollectionLoadMoreView.register(for: collection, kind: UICollectionElementKindSectionFooter)
        }
        
    }
    
    ///MARK: - UIScrollViewDelegate
    open override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        super.scrollViewWillBeginDragging(scrollView)
        if scrollView is UICollectionView {
            self.preLoadMore()
        }
    }
    
    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView is UICollectionView {
            self.preLoadMore()
        }
    }

}
