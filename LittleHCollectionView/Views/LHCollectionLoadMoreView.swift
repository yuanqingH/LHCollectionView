//
//  LHCollectionLoadMoreView.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit
public protocol LHCollectionLoadMoreViewDelegate: NSObjectProtocol{
    func didTapLoadMoreView(_ loadMoreView : LHCollectionLoadMoreView)
}
open class LHCollectionLoadMoreView: LHCollectionReusableView  {
    open weak var delegate: LHCollectionLoadMoreViewDelegate?
    var finishView: LHCollectionLoadFinishView?
    var activityLabel: LHActivityLabel?
    var loadButton : UIButton?
    
    deinit {
        self.delegate = nil
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createActivityLabel()
        self.createLoadButton()
        self.createFinisheView()
        
        self.backgroundColor = UIColor.init(white: 0.96, alpha: 1.0)
    }
    
    func createFinisheView(){
        let view = LHCollectionLoadFinishView.init(frame: self.bounds)
        self.addSubview(view)
        view.isHidden = true
        
        self.finishView = view
    }
    
    func createActivityLabel(){
        let label = LHActivityLabel.init(self.bounds, text: "加载中...")
        self.addSubview(label)
        
        self.activityLabel = label
    }
    
    func createLoadButton(){
        let btn = UIButton.init(type: .custom)
        btn.frame = self.bounds
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(LHCollectionLoadMoreView.loadAgain), for: .touchUpInside)
        btn.isHidden = true
        self.addSubview(btn)
        
        self.loadButton = btn
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setObject(_ obj: LHBaseItem) {
        super.setObject(obj)
        guard let myItem = self.item else {
            return
        }
        if myItem is LHCollectionLoadMoreItem{
            self.setNeedsLayout()
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard let myItem = self.item else {
            return
        }
        self.activityLabel?.frame = self.bounds
        self.loadButton?.frame = self.bounds
        self.finishView?.frame = self.bounds
        if myItem is LHCollectionLoadMoreItem{
            let loadMoreItem = myItem as! LHCollectionLoadMoreItem
            
            self.showLoadMoreFinishView(loadMoreItem.hasNext)
            
            self.activityLabel?.mLabel?.text = loadMoreItem.text
            
            if loadMoreItem.loading && !loadMoreItem.failed {
                self.activityLabel?.startAnimating()
            }else{
                self.activityLabel?.stopAnimation()
            }
            self.loadButton?.isHidden = !loadMoreItem.failed
            self.activityLabel?.setNeedsLayout()
        }
    }
    
    
    func showLoadMoreFinishView(_ show: Bool){
        self.finishView?.isHidden = show
        self.activityLabel?.isHidden = !show
        if !show{
            self.activityLabel?.stopAnimation()
        }
    }
    
    func loadAgain(){
        self.delegate?.didTapLoadMoreView(self)
    }
    
}


let LHActivityIndicatorViewWidth : CGFloat = 23.0
public class LHActivityLabel: UIView{
    var mLabel: UILabel?
    var activityIndicatorView: UIActivityIndicatorView?
    var isAnimation: Bool{
        get{
            guard let view = self.activityIndicatorView else{
                return false
            }
            return view.isAnimating
        }
    }
    
    deinit {
        self.activityIndicatorView?.stopAnimating()
    }
    
    public init(_ frame: CGRect, text:String) {
        super.init(frame: frame)
        //self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let label = UILabel()
        label.text = text
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.init(white: 0.53, alpha: 1.0)
        label.backgroundColor = UIColor.init(white: 0.96, alpha: 1.0)
        self.addSubview(label)
        self.mLabel = label
        
        let view = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        self.addSubview(view)
        self.activityIndicatorView = view
        
        
        self.startAnimating()
    }
    
    public func startAnimating(){
        self.activityIndicatorView?.startAnimating()
        self.activityIndicatorView?.isHidden = false
        self.layoutSubviews()
    }
    
    public func stopAnimation(){
        self.activityIndicatorView?.startAnimating()
        self.activityIndicatorView?.isHidden = true
        self.layoutSubviews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let gap : CGFloat = 7.0
        var textSize = self.mLabel?.sizeThatFits(.zero)
        textSize?.height = self.bounds.height
        let centerWidth = self.bounds.width - LHActivityIndicatorViewWidth - (textSize?.width ?? 0) - gap
        let origin_x = centerWidth / 2
        let origin_y = (self.bounds.height - LHActivityIndicatorViewWidth) / 2
        
        self.activityIndicatorView?.frame = CGRect.init(x: origin_x, y: origin_y, width: LHActivityIndicatorViewWidth, height: LHActivityIndicatorViewWidth)
        
        
        var labelOrigin_x = origin_x + LHActivityIndicatorViewWidth + gap
        let hidden = (self.activityIndicatorView?.isHidden) ?? true
        labelOrigin_x = hidden ? (self.bounds.width - (textSize?.width ?? 0))/2 : labelOrigin_x
        
        self.mLabel?.frame = CGRect.init(x:labelOrigin_x, y: 0, width: textSize?.width ?? 0, height:textSize?.height ?? 0)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LHCollectionLoadFinishView: UIView{
    var finishLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createFinisheLabel()
    }
    
    func createFinisheLabel(){
        let label = UILabel()
        label.frame = self.bounds
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .red
        label.textAlignment = .center
        label.text = "已经到最后了"
        self.addSubview(label)
        
        self.finishLabel = label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.finishLabel?.frame = self.bounds
    }
}
