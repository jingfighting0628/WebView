//
//  WKWebViewWKScriptMessageHandlerController.m
//  WebView1
//
//  Created by liuningbo on 2021/3/1.
//

#import "WKWebViewWKScriptMessageHandlerController.h"

@interface WKWebViewWKScriptMessageHandlerController ()

@end

@implementation WKWebViewWKScriptMessageHandlerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"WKScriptMessageHandler";
    self.url = @"WKWebView-WKScriptMessageHandler";
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"jsToOc"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"jsToOc"];
}
#pragma mark -- Action funtions
-(void)login
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *jsString = [NSString stringWithFormat:@"ocToJs('loginSucceed','oc_tokenString')"];
        
        [self.webView evaluateJavaScript:jsString completionHandler:^(id response, NSError * _Nullable error) {
            NSLog(@"error:%@ response:%@",error.description,response);
        }];
        
    });
}
#pragma mark -- WKNavigationDelegate
//! WKWebView在每次加载请求完成后会调用此方法
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.title" completionHandler:^(NSString *title, NSError * _Nullable error) {
        self.title = title;
    }];
}
#pragma mark -- WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
        
        [self showAlertWithTitle:message.name message:message.body cancelHandler:^{
            
        }];
    }
}
@end
