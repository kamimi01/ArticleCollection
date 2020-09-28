//
//  SettingViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionNowLabel: UILabel!
    
    let sectionNames = ["アプリ設定"]
    let appSettingKind = ["ユーザー名"]
    let cellHeight = 50
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

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
        
        // バージョンセルの設定
        versionView.backgroundColor = UIColor.white
        versionLabel.textColor = UIColor.gray
        versionNowLabel.textColor = UIColor.gray
        versionNowLabel.text = version
    }
    
    private func tableViewSetUp() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // xibの登録
        let nib = UINib(nibName: "AppSettingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AppSettingTableViewCell")
        
        tableView.rowHeight = CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.mushRoom
        
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.gray
        header?.textLabel?.font = UIFont(name: "HiraginoSans-W3", size: 13)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppSettingTableViewCell", for: indexPath ) as! AppSettingTableViewCell
        
        cell.usernameLabel.text = appSettingKind[indexPath.row]
        cell.usernameNowLabel.text = "Kamimi01"
        
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexRow = indexPath.row
        
        switch indexRow {
        case 0:
            // アラート画面を表示する
            showAlert()
        default:
            print("選択された行番号：" ,indexRow)
        }
    }
    
    // アラート画面を表示する
    private func showAlert() {
        let alert = UIAlertController.doubleBtnAlertWithTitle(title: "別のユーザーに\n切り替えますか？", message: "", okActionTitle: "OK", otherBtnTitle: "キャンセル", completion: {
            // ログイン画面に戻る
            Transition.transitionDestination(self, "Login", .fullScreen)
        })
        self.present(alert, animated: true, completion: nil)
    }

}
