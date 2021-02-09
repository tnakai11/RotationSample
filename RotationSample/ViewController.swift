//
//  ViewController.swift
//  RotationSample
//
//  Created by Takumi Nakai on 2021/02/09.
//

// 参考:
// https://i-app-tec.com/ios/iphone-safearea.htm

import UIKit

class ViewController: UIViewController {

    var label: UILabel!
    var imageView: UIImageView!
    
    var safeAreaTop: CGFloat = 0.0
    var safeAreaBottom: CGFloat = 0.0
    var safeAreaLeft: CGFloat = 0.0
    var safeAreaRight: CGFloat = 0.0
    
    var safeAreaWidth: CGFloat = 0
    var safeAreaHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // 回転動作を監視
        NotificationCenter.default.addObserver(self, selector: #selector(responseToRotation(notification:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func responseToRotation(notification: NSNotification) {
        safeAreaTop  = view.safeAreaInsets.top
        safeAreaBottom = view.safeAreaInsets.bottom
        safeAreaLeft = view.safeAreaInsets.left
        safeAreaRight = view.safeAreaInsets.right
        let viewBounds: CGRect = view.bounds
        let viewWidth: CGFloat = viewBounds.width
        let viewHeight: CGFloat = viewBounds.height
        safeAreaWidth = viewWidth - safeAreaLeft - safeAreaRight
        safeAreaHeight = viewHeight - safeAreaTop - safeAreaBottom
        setView()
    }
    
    // view に各要素を配置
    func setView(){
        let subviews:[UIView] = view.subviews
        for subview:UIView in subviews {
            subview.removeFromSuperview()
        }
        setRect()
        setLabel()
    }
    
    // view に長方形を配置
    func setRect(){
        let rect = CGRect(x: safeAreaLeft, y: safeAreaTop, width: safeAreaWidth, height: safeAreaHeight)
        imageView = UIImageView()
        imageView.frame = rect
        imageView.backgroundColor = .systemGreen
        view.addSubview(imageView)
    }
    
    // view　にテキストを配置
    func setLabel(){
        label = UILabel()
        label.frame = CGRect(x: 5, y: 100, width: 200, height: 300)
        label.text = "safeAreaWidth = " + safeAreaWidth.description
        label.textAlignment = NSTextAlignment.center
        label.center = CGPoint(x:safeAreaWidth/2,y:safeAreaHeight/2)
        view.addSubview(label)
    }
    
}

