//
//  WWTabBar.swift
//  WWTabBarControllerDemo
//
//  Created by wangweiwei on 12/27/18.
//  Copyright © 2018 wangweiwei. All rights reserved.
//

import UIKit

class WWTabBar: UITabBar {
    
    var oldSafeAreaInsets = UIEdgeInsets.zero

    // tabbar高度49
    let TabbarHeight: CGFloat = 49.0
    let centerWidth: CGFloat = 62.0
    let centerHeight: CGFloat = 48.0
    
    // 中间按钮
    public var centerBtn: UIButton = UIButton(type: .custom)
    // 中间按钮图片url
    var centerImageUrl: String? {
        didSet {
//                        centerBtn.kf.setImage(with: URL(string: centerImageUrl ?? ""), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        centerBtn.frame = CGRect(x: (UIScreen.main.bounds.size.width - centerWidth) / 2, y: -5, width: centerWidth, height: centerHeight)
        
        //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
        let btnWidth = self.frame.size.width / 5
        for btn in self.subviews {
            if btn.isKind(of: NSClassFromString("UITabBarButton")!.self) {
                let label = btn.value(forKeyPath: "_label") as! UILabel
                
                switch (label.text ?? "") {
                case "首页":
                    btn.frame = CGRect(x: 0,
                                       y: 0,
                                       width: btnWidth,
                                       height: TabbarHeight)
                    
                case "探索":
                    btn.frame = CGRect(x: btnWidth,
                                       y: 0,
                                       width: btnWidth,
                                       height: TabbarHeight)
                case "发现":
                    btn.frame = CGRect(x: btnWidth * 3,
                                       y: 0,
                                       width: btnWidth,
                                       height: TabbarHeight)
                    
                    
                case "我的":
                    btn.frame = CGRect(x: btnWidth * 4,
                                       y: 0,
                                       width: btnWidth,
                                       height: TabbarHeight)
                default:
                    return
                }
                
                
            }
            
        }
    }
    
    func initView() -> Void {
        centerBtn.adjustsImageWhenHighlighted = false
        addSubview(centerBtn)
    }
    
    // 处理超出tabbar部分按钮点击无效的问题
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isHidden {
            // 转换坐标
            let tempPoint = centerBtn.convert(point, from: self)
            // 判断点击的点是否在按钮区域内
            if centerBtn.bounds.contains(tempPoint) {
                // 返回按钮
                return centerBtn
            }
        }
        return super.hitTest(point, with: event)
    }
    
    /**
     防止iOS11 push页面时候tabbar偏移
     */
    
    
    @available(iOS 11.0, *)
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        
        if oldSafeAreaInsets != safeAreaInsets {
            oldSafeAreaInsets = safeAreaInsets
            
            invalidateIntrinsicContentSize()
            superview?.setNeedsLayout()
            superview?.layoutSubviews()
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        if #available(iOS 11.0, *) {
            let bottomInset = safeAreaInsets.bottom
            if bottomInset > 0 && size.height < 50 && (size.height + bottomInset < 90) {
                size.height += bottomInset
            }
        }
        return size
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var tmp = newValue
            if let superview = superview, tmp.maxY !=
                superview.frame.height {
                tmp.origin.y = superview.frame.height - tmp.height
            }
            
            super.frame = tmp
        }
    }
}
