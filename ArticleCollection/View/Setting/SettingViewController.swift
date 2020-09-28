//
//  SettingViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let sectionNames = ["アプリ設定"]
    let appSettingKind = ["ユーザー名"]

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
        
        // tableViewの設定
        tableViewSetUp()
    }
    
    private func tableViewSetUp() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // xibの登録
        let nib = UINib(nibName: "AppSettingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AppSettingTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppSettingTableViewCell", for: indexPath ) as! AppSettingTableViewCell
        
        cell.usernameLabel.text = appSettingKind[indexPath.row]
        cell.usernameNowLabel.text = "Kamimi01"
        return cell
    }

}
