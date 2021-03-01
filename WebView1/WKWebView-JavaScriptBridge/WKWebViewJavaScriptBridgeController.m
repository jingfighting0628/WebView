//
//  WKWebViewJavaScriptBridgeController.m
//  WebView1
//
//  Created by liuningbo on 2021/3/1.
//

#import "WKWebViewJavaScriptBridgeController.h"
#import <WKWebViewJavascriptBridge.h>
@interface WKWebViewJavaScriptBridgeController ()
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@end

@implementation WKWebViewJavaScriptBridgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"WKWebViewJavascriptBridge";
    self.url = @"WKWebView-JavascriptBridge";
    
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge registerHandler:@"jsToOc" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSArray *arr = data;
        
        [self showAlertWithTitle:@"jsToOc" message:arr.description cancelHandler:^{
            
        }];
        
        
    }];

}
#pragma mark -- Action functions

- (void)login
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.bridge callHandler:@"ocToJs" data:@[@"loginSucceed", @"oc_tokenString"] responseCallback:^(id responseData) {
            NSLog(@"responseData :%@",responseData);
        }];
        
    });
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
