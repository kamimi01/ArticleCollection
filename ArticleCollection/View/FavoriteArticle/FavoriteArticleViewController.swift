//
//  FavoriteArticleViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/29.
//

import UIKit

class FavoriteArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let siteNameList = ["Qiita", "note", "Hatena Blog"]
    let articleNameList = ["色んな人向けにバーチャルSNS - cluster - に関するリンクを広く浅くまとめてみた", "プログラミング初心者がポートフォリオを公開するまでの27時間を振り返ってみた", "色んな人向けにバーチャルSNS - cluster - に関するリンクを広く浅くまとめてみた"]
    let usernameList = ["kamimi01"]
    let goodNameList = ["LGTM", "スキ", "いいね"]
    let goodNumList = [45, 3, 10]
    let userImageList = ["noUserImage", "noUserImage"]
    let urlList = ["https://qiita.com/kamimi01/items/353ed9502ed62cbe9864", "https://qiita.com/kamimi01/items/7d9584cd9b5988421c4a"]
    let iconImageList = ["https://avatars1.githubusercontent.com/u/47489629?v=4", "https://avatars1.githubusercontent.com/u/47489629?v=4", "https://avatars1.githubusercontent.com/u/47489629?v=4"]
    let createdDateList = ["2021/10/10に", "2020/6/24に", "2020/6/24に"]
    let cellHeight = 142
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        // ナビゲーションバーの設定
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.onion
        navBar?.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // tableViewの設定
        tableViewSetUp()

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

        cell.siteNameLabel.text = siteNameList[indexRow]
        cell.siteNameLabel.customizeLabel(.tag, siteNameList[indexRow])
        cell.articleNameLabel.text = articleNameList[indexRow]
        cell.createdDateLabel.text = createdDateList[indexRow]
        cell.goodNameLabel.text = goodNameList[indexRow]
        cell.goodNumLabel.text = String(goodNumList[indexRow])
        cell.iconImageView.customizeImage(.urlShow, "", iconImageList[indexRow])
        
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // webViewに遷移する
        Transition.transitionDestination(self, "WebView", .fullScreen)
    }

}
