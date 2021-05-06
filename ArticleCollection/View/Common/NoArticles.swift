//
//  NoArticles.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/05.
//

import Foundation
import UIKit
import Lottie

class NoArticles: UIView {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var noArticleLabel: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    override func layoutSubviews() {
        backView.backgroundColor = UIColor.white
        animationView.backgroundColor = UIColor.white
        noArticleLabel.textColor = UIColor.boldGray
        
        // アニメーション表示
        // 1. Set animation content mode
        animationView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        animationView.loopMode = .loop
        // 3. Adjust animation speed
        animationView.animationSpeed = 1.0
        // 4. Play animation
        animationView.play()
        print("こっちは呼ばれてない")
    }
}
