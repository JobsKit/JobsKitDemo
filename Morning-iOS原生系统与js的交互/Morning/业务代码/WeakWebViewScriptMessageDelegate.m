//
//  WeakWebViewScriptMessageDelegate.m
//  Morning
//
//  Created by Jobs on 2022/9/30.
//

#import "WeakWebViewScriptMessageDelegate.h"

@interface WeakWebViewScriptMessageDelegate()

@end

@implementation WeakWebViewScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    if (self = [super init]) {
        _scriptDelegate = scriptDelegate;
    }return self;
}
    
#pragma mark —— WKScriptMessageHandler
    //遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
    //通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController
                           didReceiveScriptMessage:message];
    }
}
    

@end
