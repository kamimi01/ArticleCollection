//
//  Transition.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import Foundation
import UIKit

class Transition: UIViewController {
    // storyboardを跨いだ遷移
    public static func transitionDestination(_ vc: UIViewController, _ storyboardName: String, _ transitionType: UIModalPresentationStyle) {
        let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
        viewController?.modalPresentationStyle = transitionType
        vc.present(viewController!, animated: true, completion: nil)
    }
    
    // storyboardを跨いだ遷移
    public static func transitionPushDestination(_ vc: UIViewController, _ storyboardName: String) {
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let naviView = storyboard.instantiateInitialViewController() as! UINavigationController
        let view = naviView.topViewController as! AppInfoViewController
//        view.hogehoge = "ほげほげ"
        vc.navigationController?.pushViewController(view, animated: true)
    }
}
