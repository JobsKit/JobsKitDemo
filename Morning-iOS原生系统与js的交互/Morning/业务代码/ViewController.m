//
//  ViewController.m
//  Morning
//
//  Created by Jobs on 2022/9/30.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)WKBackForwardList *backForwardList;/// 可返回的页面列表, 存储已打开过的网页
/// 加载一个本地的请求
@property(nonatomic,strong)NSMutableURLRequest *urlRequest;
/// 加载本地html文件
@property(nonatomic,strong)NSString *path;
@property(nonatomic,strong)NSString *htmlStr;
/// 为WKWebView添加配置信息
@property(nonatomic,strong)WKWebViewConfiguration *webViewConfig;
@property(nonatomic,strong)WKPreferences *preferences;///  创建设置对象
@property(nonatomic,strong)WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate;/// 自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
@property(nonatomic,strong)NSMutableArray *jsCallOCMethodNames;/// 是一个 js 调用 OC 的方法名称的数组，是一个 js 调用 OC 的方法名称的数组
@property(nonatomic,strong)WKUserContentController *ucCtr;/// 专门用来管理native与JavaScript的交互行为
@property(nonatomic,strong)NSString *jsStr;
@property(nonatomic,strong)WKUserScript *userScript;/// 用于进行JavaScript注入

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.alpha = 1;
    [self kkk];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches
//          withEvent:(UIEvent *)event{
//    self.webView.alpha = 1;
//    [self kkk];
//}
#pragma mark —— 一些私有方法
-(void)一些操作手法{
    // 是否可以后退，返回 BOOL  YES 可以后退， NO 第一页，不可以后退，可以做 pop webView  操作
    if (self.webView.canGoBack) {
    // 页面后退
        [self.webView goBack];
    }else {
    // pop webView 退出 webView 页面
    }
    // 是否可以前进，返回 BOOL  YES 可以前进， NO 第一页，不可以前进
    if (self.webView.canGoForward) {
        //页面前进
        [self.webView goForward];
    }else {
    // 没有下一页
    }
    // 刷新当前页面
    [self.webView reload];
}
/// 【第二类：OC 主动调用 JS 的方法】
-(void)kkk{
    // OC 调用 JS 方法 并传参数 jsonString，  当不需要参数时，可以 ('') 这样处理
    [self.webView evaluateJavaScript: @"OCCallJSMethod('jsonString')"
                   completionHandler:^(id response, NSError * error) {
        NSLog(@"response: %@, \nerror: %@", response, error);
        
        /**
         设置 userAgent
         
         if (![oldAgent isKindOfClass:[NSString class]]) {
             // 为了避免没有获取到oldAgent，所以设置一个默认的userAgent
             // Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148
             oldAgent = [NSString stringWithFormat:@"Mozilla/5.0 (%@; CPU iPhone OS %@ like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E216", [[UIDevice currentDevice] model], [[[UIDevice currentDevice] systemVersion] stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
         }
         
         NSString *userAgentSuffix = @"自己想要拼接的标识";
         //自定义user-agent
         if (![oldAgent hasSuffix:userAgentSuffix]) {
             NSString *newAgent =  [oldAgent stringByAppendingFormat:@" %@",userAgentSuffix];;
             [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":newAgent}];
             [[NSUserDefaults standardUserDefaults] synchronize];
             // 一定要设置customUserAgent，否则执行navigator.userAgent拿不到oldAgent
             webView.customUserAgent = newAgent;
         }
         
         */
    }];
}
/// 【第一类：JS 主动调用 OC 的方法（带参数以及返回值）】❤️这种方法不需要注册监听，是使用 UIDelegate 方法❤️
- (void)webView:(WKWebView *)webView
runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt
    defaultText:(nullable NSString *)defaultText
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    if (prompt) {
        // defaultText  是JS 传的JsonString参数
        if (defaultText.length) {
            // 说明有参数
        }
        if ([prompt isEqualToString:@"jsCallOCReturnJsonStringMethod"]) {
            completionHandler(@"返回的结果，可以自定义");
        }
    }
}
#pragma mark —— WKScriptMessageHandler
///【第一类：JS 主动调用 OC 的方法（无参数）】处理添加监听的方法名
/// WKScriptMessage类是JavaScript传递的对象实例
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    // message.name 添加监听的方法名【❤️不带参数的方法❤️】
    if ([message.name isEqualToString: @"JSCallOCMethod1"]) {
        //  message.body   是 `js` 传递的参数 ,一般是 json 字符串
        NSLog(@"MessageBody: %@", message.body);
    }
}
#pragma mark —— LazyLoad
/// https://www.jianshu.com/p/5cf0d241ae12
-(WKWebView *)webView{
    if(!_webView){
        /// 两种创建方式
        // _webView = WKWebView.new;
        // _webView.frame = self.view.bounds;
        
        _webView = [WKWebView.alloc initWithFrame:self.view.bounds
                                    configuration:self.webViewConfig];

        [self.view addSubview:_webView];
        // UI代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;

        // 加载本地html文件
//        [_webView loadHTMLString:self.htmlStr
//                         baseURL:[NSURL fileURLWithPath:NSBundle.mainBundle.bundlePath]];
        // 加载本地URL
        [_webView loadRequest:self.urlRequest];
        
    }return _webView;
}

-(WKBackForwardList *)backForwardList{
    if(!_backForwardList){
        _backForwardList = self.webView.backForwardList;
    }return _backForwardList;
}

-(NSMutableURLRequest *)urlRequest{
    if(!_urlRequest){
        _urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.wingsong.xyz/"]];
        [_urlRequest addValue:@"" forHTTPHeaderField:@"Cookie"];
    }return _urlRequest;
}

-(NSString *)path{
    if(!_path){
        _path = [NSBundle.mainBundle pathForResource:@"JStoOC.html" ofType:nil];
    }return _path;
}

-(NSString *)htmlStr{
    if(!_htmlStr){
        _htmlStr = [NSString.alloc initWithContentsOfFile:self.path
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil];
    }return _htmlStr;
}

-(NSString *)jsStr{
    if (!_jsStr) {
        _jsStr = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
    }return _jsStr;
}

-(WKUserScript *)userScript{
    if (!_userScript) {
        _userScript = [WKUserScript.alloc initWithSource:self.jsStr
                                           injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                        forMainFrameOnly:YES];
    }return _userScript;
}

-(WKUserContentController *)ucCtr{
    if (!_ucCtr) {
        _ucCtr = WKUserContentController.new;
        [_ucCtr addUserScript:self.userScript];
        for (NSString *methodName in self.jsCallOCMethodNames) {
            /**
             ❤️添加方法名监听 (主要是这步)❤️
             
             这样就添加了一个 JS 调用 OC 的方法监听
             当 JS 调用方法时
             通过WKScriptMessageHandler 代理方法来获取 JS 调用 OC 的方法的处理
             */
             [_ucCtr addScriptMessageHandler:self.weakScriptMessageDelegate
                                        name:methodName];
        }
    }return _ucCtr;
}

-(NSMutableArray *)jsCallOCMethodNames{
    if (!_jsCallOCMethodNames) {
        _jsCallOCMethodNames = NSMutableArray.array;
        [_jsCallOCMethodNames addObject:@"JSCallOCMethod1"];
        [_jsCallOCMethodNames addObject:@"JSCallOCMethod2"];
    }return _jsCallOCMethodNames;
}

-(WKWebViewConfiguration *)webViewConfig{
    if(!_webViewConfig){
        _webViewConfig = WKWebViewConfiguration.new;
        _webViewConfig.preferences = self.preferences;
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        _webViewConfig.allowsInlineMediaPlayback = YES;
        // 设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        _webViewConfig.requiresUserActionForMediaPlayback = YES;
        // 设置是否允许画中画技术 在特定设备上有效
        _webViewConfig.allowsPictureInPictureMediaPlayback = YES;
        // 设置请求的User-Agent信息中应用程序名称 iOS9后可用
        _webViewConfig.applicationNameForUserAgent = @"ChinaDailyForiPad";
        _webViewConfig.userContentController = self.ucCtr;
    }return _webViewConfig;
}

-(WKPreferences *)preferences{
    if(!_preferences){
        _preferences = WKPreferences.new;
        // 最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        _preferences.minimumFontSize = 0;
        // 设置是否支持javaScript 默认是支持的
        _preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        _preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
    }return _preferences;
}

-(WeakWebViewScriptMessageDelegate *)weakScriptMessageDelegate{
    if(!_weakScriptMessageDelegate){
        _weakScriptMessageDelegate = [WeakWebViewScriptMessageDelegate.alloc initWithDelegate:self];
    }return _weakScriptMessageDelegate;
}

@end
