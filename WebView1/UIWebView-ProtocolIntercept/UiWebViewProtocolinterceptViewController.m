//
//  UiWebViewProtocolinterceptViewController.m
//  WebView1
//
//  Created by liuningbo on 2021/3/1.
//  UIWebView协议拦截

#import "UiWebViewProtocolinterceptViewController.h"

@interface UiWebViewProtocolinterceptViewController ()

@end

@implementation UiWebViewProtocolinterceptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"UIWebView-Intercept" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

#pragma mark - Action functions

-(void)login
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *jsString = [NSString stringWithFormat:@"ocToJs('loginSucceed','oc_tokenString')"];
        
        [self.webView stringByEvaluatingJavaScriptFromString:jsString];
        
    });
    
}
#pragma mark - UIWebViewDelegate
//! UIWebView在每次加载请求前会调用此方法来确认是否加载此请求
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.URL.scheme caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
        
        [self showAlertWithTitle:request.URL.host message:request.URL.query cancelHandler:^{
            
        }];
        return NO;
        
    }
    return YES;
}
//! UIWebView在每次加载请求完成后会调用此方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
@end
