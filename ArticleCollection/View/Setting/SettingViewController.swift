//
//  SettingViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        // view全体の設定
        view.backgroundColor = UIColor.mushRoom
        
        // ナビゲーションバーの設定
        self.navigationController?.navigationBar.barTintColor = UIColor.mushRoom
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
    }

}
