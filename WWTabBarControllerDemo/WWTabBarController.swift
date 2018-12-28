//
// Created by wangweiwei on 2018-12-28.
// Copyright (c) 2018 wangweiwei. All rights reserved.
//

import Foundation
import UIKit

class WWTabBarController: UITabBarController {
    var isShow = false
    var tabIcon: UIImage?
    var tabIconUrl: String?
    var toUrl: String?

    var customTabbar: WWTabBar?


    init(isShowPlus: Bool, icon: UIImage?, iconUrl: String?, uri: String?) {
        isShow = isShowPlus
        tabIcon = icon
        tabIconUrl = iconUrl
        toUrl = uri
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if isShow {
            customTabbar = WWTabBar(frame: .zero)
            setValue(customTabbar, forKeyPath: "tabBar")
            customTabbar?.centerBtn.addTarget(self, action: #selector(centerBtnAction), for: .touchUpInside)
        }
    }



    // 中间按钮点击
    @objc func centerBtnAction() {
//        LocalRouter.shared.open(url: toUrl ?? "")
    }


}