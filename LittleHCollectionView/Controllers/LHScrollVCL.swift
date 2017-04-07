//
//  LHScrollVCL.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit
public enum LHScrollVerticalDirection{
    case defualt
    case up
    case down
}
class LHScrollVCL: LHBaseVCL,UIScrollViewDelegate {

    public var previousOffset : CGPoint = CGPoint.zero
    ///用户操作的滚动方向
    public var verticalDirection : LHScrollVerticalDirection = .defualt
    ///用户操作导致的滚动
    public var isInteractionScroll : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UIScrollViewDelegate
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            if !self.isInteractionScroll{
                //如果不是用户的交互则直接返回
                return
            }
            
            let offSet = scrollView.contentOffset
            if offSet.y - self.previousOffset.y > 0 {
                //向上滑动
                self.verticalDirection = .up
            }else if(offSet.y - self.previousOffset.y < 0){
                //向下滑动
                self.verticalDirection = .down
            }else{
                self.verticalDirection = .defualt
            }
            self.previousOffset = offSet
        }
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            self.previousOffset = scrollView.contentOffset
            self.isInteractionScroll = true
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView{
            self.isInteractionScroll = false
        }
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView is UICollectionView{
            if !decelerate {
                self.isInteractionScroll = false
            }
        }
    }

}
