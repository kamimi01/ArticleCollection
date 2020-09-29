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
    let articleNameList = ["色んな人向けにバーチャルSNS - cluster - に関するリンクを広く浅くまとめてみた", "プログラミング初心者がポートフォリオを公開するまでの27時間を振り返ってみた"]
    let usernameList = ["kamimi01"]
    let goodNameList = ["LGTM"]
    let goodNumList = [0, 3]
    let userImageList = ["noUserImage", "noUserImage"]
    let urlList = ["https://qiita.com/kamimi01/items/353ed9502ed62cbe9864", "https://qiita.com/kamimi01/items/7d9584cd9b5988421c4a"]
    let cellHeight = 110
    
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
        
        // 
        tableView.backgroundColor = UIColor.white
    }
    
    private func tableViewSetUp() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // xibの登録
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
        
        tableView.rowHeight = CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath ) as! ArticleTableViewCell
        
        let indexRow = indexPath.row

        cell.siteNameLabel.text = siteNameList[0]
        cell.articleNameLabel.text = articleNameList[indexRow]
        cell.userNameLabel.text = usernameList[0]
        cell.goodNameLabel.text = goodNameList[0]
        cell.goodNumLabel.text = String(goodNumList[indexRow])
        cell.iconImageView.customizeImage(.main, userImageList[indexRow])
        
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
}
