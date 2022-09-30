//
//  WeakWebViewScriptMessageDelegate.h
//  Morning
//
//  Created by Jobs on 2022/9/30.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 防止循环引用 WebViewScriptMessageDelegate 所以创建一个弱引用的 WeakWebViewScriptMessageDelegate
@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>
/// WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property(nonatomic,weak)id<WKScriptMessageHandler> scriptDelegate;
    
-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
