//
//  TabBarViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    

    private func setup() {
        // タブアイコンがアクティブな時の設定
        UITabBar.appearance().tintColor = UIColor.driftWood
    }

}
