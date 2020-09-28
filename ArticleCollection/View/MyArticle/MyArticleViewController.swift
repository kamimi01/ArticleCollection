//
//  MyArticleViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/28.
//

import UIKit

class MyArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let siteNameList = ["Qiita"]
    let articleNameList = ["いろんな人向けにバーチャルSNSを紹介したい", "いろんな人向けにバーチャルSNSを紹介したい"]
    let usernameList = ["kamimi01"]
    let goodNameList = ["LGTM"]
    let goodNumList = [0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        // ナビゲーションバーの設定
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.mushRoom
        navBar?.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
        
        // tableViewの設定
        tableViewSetUp()
    }
    
    private func tableViewSetUp() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // xibの登録
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath ) as! ArticleTableViewCell
        
        cell.iconImageView.customizeImage(.main, "")
        cell.siteNameLabel.text = siteNameList[0]
        cell.articleNameLabel.text = articleNameList[indexPath.row]
        cell.userNameLabel.text = usernameList[0]
        cell.goodNameLabel.text = goodNameList[0]
        cell.goodNumLabel.text = String(goodNumList[0])
        
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
}
