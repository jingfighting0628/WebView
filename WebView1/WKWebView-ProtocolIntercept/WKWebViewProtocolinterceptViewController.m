//
//  WKWebViewProtocolinterceptViewController.m
//  WebView1
//
//  Created by liuningbo on 2021/3/1.
//  WKWebView协议拦截

#import "WKWebViewProtocolinterceptViewController.h"

@interface WKWebViewProtocolinterceptViewController ()

@end

@implementation WKWebViewProtocolinterceptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WKWebView-Intercept协议拦截";
    // Do any additional setup after loading the view.
    self.url = @"WKWebView-Intercept";
}
#pragma mark - Action functions

-(void)login
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.webView evaluateJavaScript:@"ocToJs('loginSucceed','oc_tokenString')" completionHandler:^(id response, NSError * _Nullable error) {
            
            NSLog(@"response :%@",response);
            
        }];
    });
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
    if ([navigationAction.request.URL.scheme caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
        
        [self showAlertWithTitle:navigationAction.request.URL.host message:navigationAction.request.URL.query cancelHandler:^{
            
        }];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.title" completionHandler:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
