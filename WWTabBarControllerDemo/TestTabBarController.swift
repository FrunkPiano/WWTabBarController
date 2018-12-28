//
// Created by wangweiwei on 2018-12-28.
// Copyright (c) 2018 wangweiwei. All rights reserved.
//

import Foundation
import UIKit
class TestTabBarController: WWTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //选中时的颜色
        customTabbar?.tintColor = UIColor(red: 251.0/255.0, green: 199.0/255.0, blue: 115.0/255.0, alpha: 1)
        //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
        customTabbar?.isTranslucent = false

//        customTabbar?.centerImage = UIImage(named: "tabbar_add_yellow")!

        addChildViewControllers()
    }

    //添加子控制器
    func addChildViewControllers() {
        //图片大小建议32*32
        addChildViewController(ViewController(), title: "首页", imageName: "tab1")
        addChildViewController(ViewController(), title: "应用", imageName: "tab2")
        addChildViewController(ViewController(), title: "消息", imageName: "tab3")
        addChildViewController(ViewController(), title: "我的", imageName: "tab4")
    }


    // 添加子vc
    func addChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        childController.title = title
        if imageName.count > 0{
            childController.tabBarItem.image = UIImage(named: imageName)
            childController.tabBarItem.selectedImage = UIImage(named: imageName)
        }
        let nav = UINavigationController(rootViewController: childController)
        addChild(nav)

    }



}