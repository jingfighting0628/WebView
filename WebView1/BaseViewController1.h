//
//  BaseViewController1.h
//  WebView1
//
//  Created by liuningbo on 2021/3/1.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController1 : UIViewController<WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) WKWebView *webView;
- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message cancelHandler:(void(^)(void))handler ;
@end

NS_ASSUME_NONNULL_END
