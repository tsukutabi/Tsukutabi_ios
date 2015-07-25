//
//  ViewController.swift
//  WebViewrensyu
//
//  Created by Ryosei Takahashi on 2015/07/19.
//  Copyright (c) 2015年 Ryosei Takahashi. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController ,UIWebViewDelegate{
    
    //var webview: UIWebView = UIWebView()
    @IBOutlet weak var webview: UIWebView!
    private var myToolbar: UIToolbar!
    private var backToolbar: UIToolbar!
    var myComposeView : SLComposeViewController!
    var myTwitterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.webview.frame = self.view.bounds
        self.webview.delegate = self;
        //self.view.addSubview(self.webview)
        
        Top()
        
        // 背景を青色に変更する.
        self.view.backgroundColor = UIColor.cyanColor()
        
        // ツールバーのサイズを決める.
        myToolbar = UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 40.0))
        
        // ツールバーの位置を決める.
        myToolbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height-20.0)
        
        // ツールバーの色を決める.
        myToolbar.barStyle = .BlackTranslucent
        myToolbar.tintColor = UIColor.whiteColor()
        myToolbar.backgroundColor = UIColor.blackColor()
        
        // ボタン１を生成する.
        let myUIBarButtonGreen: UIBarButtonItem = UIBarButtonItem(title: "Green", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonGreen.tag = 1
        
        // ボタン２を生成する.
        let myUIBarButtonTweet: UIBarButtonItem = UIBarButtonItem(title: "Tweet", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonTweet.tag = 2
        
        // ボタン3を生成する.
        let myUIBarButtonRed: UIBarButtonItem = UIBarButtonItem(title: "top", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonRed.tag = 3
        
        // ボタン3を生成する.
        let myUIBarButtonyellow: UIBarButtonItem = UIBarButtonItem(title: "back", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonyellow.tag = 4
        
        let myUIBarButtonOrange: UIBarButtonItem = UIBarButtonItem(title: "profile", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonOrange.tag = 5
        
        // ボタンをツールバーに入れる.
        myToolbar.items = [myUIBarButtonGreen, myUIBarButtonTweet, myUIBarButtonRed,myUIBarButtonyellow, myUIBarButtonOrange]
        
        // ツールバーに追加する.
        self.view.addSubview(myToolbar)
        
        // Twitter用のUIButtonの生成.
        let hex: Int = 0x55ACEE
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let Tweet = Double((hex & 0xFF)) / 255.0
        var myColor: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1.0))
        
        // ボタン.
        myTwitterButton = UIButton()
        myTwitterButton.frame = CGRectMake(0,0,100,100)
        myTwitterButton.backgroundColor = myColor
        myTwitterButton.layer.masksToBounds = true
        myTwitterButton.setTitle("Twitter", forState: UIControlState.Normal)
        myTwitterButton.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(20))
        myTwitterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myTwitterButton.layer.cornerRadius = 50.0
        myTwitterButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2)
        myTwitterButton.tag = 1
        myTwitterButton.addTarget(self, action: "onPostToTwitter:", forControlEvents: .TouchUpInside)
        
        // buttonをviewに追加.
        self.view.addSubview(myTwitterButton)
        
    }
    
    /*
    UIBarButtonItemが押された際に呼ばれる.
    */
    internal func onClickBarButton(sender: UIBarButtonItem) {
        
        switch sender.tag {
        case 1:
            self.view.backgroundColor = UIColor.greenColor()
            toukou()
        case 2:
            self.view.backgroundColor = UIColor.blueColor()
        case 3:
            self.view.backgroundColor = UIColor.redColor()
            Top()
        case 4:
            self.view.backgroundColor = UIColor.redColor()
            Top()
        case 5:
            self.view.backgroundColor = UIColor.redColor()
            mypage()
        default:
            println("ERROR!!")
        }
    }
    
    func Top(){
        var url: NSURL = NSURL(string: "http://realvoicenext.sakura.ne.jp/cakephp/")!
        var urlRequest: NSURLRequest = NSURLRequest(URL: url)
        self.webview.loadRequest(urlRequest)
    }
    
    func toukou(){
        var url: NSURL = NSURL(string: "http://q.hatena.ne.jp/1430472952")!
        var urlRequest: NSURLRequest = NSURLRequest(URL: url)
        self.webview.loadRequest(urlRequest)
    }
    
    func mypage(){
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return true
    }
    
    
    // ボタンイベント.
    func onPostToTwitter(sender : AnyObject) {
        
        // SLComposeViewControllerのインスタンス化.
        // ServiceTypeをTwitterに指定.
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 投稿するテキストを指定.
        myComposeView.setInitialText("Twitter Test from Swift")
        
        // 投稿する画像を指定.
        myComposeView.addImage(UIImage(named: "oouchi.jpg"))
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
}