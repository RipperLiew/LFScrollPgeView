//
//  LFScrollPageView.swift
//  LFScrollPageView
//
//  Created by zhangxc on 2018/3/13.
//  Copyright © 2018年 fantasee. All rights reserved.
//

import UIKit

class LFScrollPageView: UIView {

    // MARK:- 定义属性
    /// 滚动头部标题字符串数组
    fileprivate var titles : [String]!
    /// 所有子控制器数组
    fileprivate var childVcs : [UIViewController]!
    /// 父控制器
    fileprivate var parentVc : UIViewController!
    /// 标题风格
    fileprivate var style : LFTitleStyle!
    /// 标题滚动视图
    fileprivate var titleView : LFTitleView!
    /// 显示的视图
    fileprivate var contentView : LFContentView!
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles: [String], style : LFTitleStyle, childVcs : [UIViewController], parentVc : UIViewController) {
        super.init(frame: frame)
        
        self.style = style
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
    
        parentVc.automaticallyAdjustsScrollViewInsets = false;
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置UI界面内容
extension LFScrollPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = style.titleHeight
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = LFTitleView(frame: titleFrame, titles: titles, style: style)
        titleView.delegate = self
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = LFContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
        
    }
}

// MARK:- 设置LFContentView的代理
extension LFScrollPageView : LFContentViewDelegate {
    func contentView(_ contentView: LFContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: LFContentView) {
        titleView.contentViewDidEndScroll()
    }
}

// MARK:- 设置LFTitleView的代理
extension LFScrollPageView : LFTitleViewDelegate {
    func titleView(_ titleView: LFTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}

