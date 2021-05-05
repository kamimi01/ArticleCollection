//
//  AppInfoViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/05.
//

import Foundation
import UIKit

class AppInfoViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var animationLicenseLabel: UILabel!
    @IBOutlet weak var privacyPolicyTextView: UITextView!
    @IBOutlet weak var licenseTextView: UITextView!
    @IBOutlet weak var animationLicenseTextView: UITextView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var separator2View: UIView!
    
    let privacyPolicyText = "本アプリケーションの使用にあたり、こちらの規約をご確認ください。"
    let licenseText = """
        本アプリケーションは、端末の設定に記載の
        オープンソースソフトウェアを使用しています。

        確認方法
        1. 端末の「設定」を開く
        2. 「Kijiコレ」を選択する
        3. 「Licenses」を選択する
        """
    let animationLicenseText = """
        Rizwan Rasool19 on LottieFiles:
        https://lottiefiles.com/16656-empty-state
        """
    let privacyPolicyUrl = "https://www.google.co.jp/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        privacyPolicyLabel.textColor = UIColor.gray
        licenseLabel.textColor = UIColor.gray
        animationLicenseLabel.textColor = UIColor.gray
        
        privacyPolicyTextView.isEditable = false
        licenseTextView.isEditable = false
        animationLicenseTextView.isEditable = false
        privacyPolicyTextView.isScrollEnabled = false
        licenseTextView.isScrollEnabled = false
        animationLicenseTextView.isScrollEnabled = false
        
        privacyPolicyTextView.text = privacyPolicyText
        licenseTextView.text = licenseText
        animationLicenseTextView.text = animationLicenseText
        
        separatorView.backgroundColor = UIColor.gray
        separator2View.backgroundColor = UIColor.gray
        
        // textview内にリンクを設置
        let attributedString = NSMutableAttributedString(string: privacyPolicyText)

        attributedString.addAttribute(.link,
                                      value: privacyPolicyUrl,
                                      range: NSString(string: privacyPolicyText).range(of: "こちら"))
        
        privacyPolicyTextView.attributedText = attributedString
        privacyPolicyTextView.isSelectable = true
        privacyPolicyTextView.delegate = self
    }
    
    func textView(_ textView: UITextView,
                      shouldInteractWith URL: URL,
                      in characterRange: NSRange,
                      interaction: UITextItemInteraction) -> Bool {

        UIApplication.shared.open(URL)

        return false
    }
}
