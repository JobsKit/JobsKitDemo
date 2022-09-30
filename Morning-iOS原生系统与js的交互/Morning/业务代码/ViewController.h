//
//  ViewController.h
//  Morning
//
//  Created by Jobs on 2022/9/30.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "WeakWebViewScriptMessageDelegate.h"
/// 学习资料来源：
/// https://www.jianshu.com/p/3b1ac23c8749
/// https://www.jianshu.com/p/29e0d8ab91f1
@interface ViewController : UIViewController
<
WKUIDelegate
,WKNavigationDelegate
,WKScriptMessageHandler
>


@end

