//
//  MyArticleViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/28.
//

import UIKit
import Lottie

class MyArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ArticleCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let siteNameList = ["Qiita", "note", "hatena"]
    let displaySiteNameList = [" Qiita ", " note ", " Hatena Blog "]
    let articleNameList = ["色んな人向けにバーチャルSNS - cluster - に関するリンクを広く浅くまとめてみた", "せるふ - いんとろだくしょん", "色んな人向けにバーチャルSNS - cluster - に関するリンクを広く浅くまとめてみた"]
    let usernameList = ["kamimi01"]
    let goodNameList = ["LGTM", "スキ", "いいね"]
    let goodNumList = [45, 8, 10]
    let userImageList = ["noUserImage", "noUserImage"]
    let urlList = ["https://qiita.com/kamimi01/items/353ed9502ed62cbe9864", "https://note.com/kamimi01/n/n3f1bbf2c3d09", "https://qiita.com/kamimi01/items/7d9584cd9b5988421c4a"]
    let iconImageList = ["https://avatars1.githubusercontent.com/u/47489629?v=4", "https://assets.st-note.com/production/uploads/images/41663416/profile_9c349fef5e606ef83cce8b4704a77620.jpg?fit=bounds&format=jpeg&quality=85&width=330", "https://avatars1.githubusercontent.com/u/47489629?v=4"]
    let createdDateList = ["2021/10/10に", "2020/6/24に", "2020/6/24に"]
    // シングルトンのインスタンスを作成する
    let articleStateManager: ArticleStateManager = ArticleStateManager.shared
    
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
        
        // 
        tableView.backgroundColor = UIColor.white
        
        articleStateManager.favoriteStatusList = [Bool](repeating: false, count: 3)
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

        cell.siteNameLabel.text = displaySiteNameList[indexRow]
        cell.siteNameLabel.customizeLabel(.tag, siteNameList[indexRow])
        cell.articleNameLabel.text = articleNameList[indexRow]
        cell.createdDateLabel.text = createdDateList[indexRow]
        cell.goodNameLabel.text = goodNameList[indexRow]
        cell.goodNumLabel.text = String(goodNumList[indexRow])
        cell.iconImageView.customizeImage(.urlShow, "", iconImageList[indexRow])

        cell.delegte = self
        cell.index = indexPath
        
        print("tableviewどこが呼ばれてる？", articleStateManager.favoriteStatusList[indexRow])
        
        if articleStateManager.favoriteStatusList[indexRow] {
            print("表示切り替えが呼ばれる")
            // ピンクのハートを表示する
//            addAnimationView(cell: cell)
            cell.animationView.isHidden = false
            cell.favoriteImageView.isHidden = true
        } else {
            // 灰色画像を表示する
            cell.animationView.isHidden = true
            cell.favoriteImageView.isHidden = false
        }

        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // webViewに遷移する
        Transition.transitionDestination(self, "WebView", .fullScreen)
    }
    
    func reloadCell(index: IndexPath) {
        print("ここでは", articleStateManager.favoriteStatusList)
        tableView.reloadRows(at: [index], with: .fade)
    }
}
