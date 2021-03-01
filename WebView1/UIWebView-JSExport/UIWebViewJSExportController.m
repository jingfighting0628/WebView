//
//  UIWebViewJSExportController.m
//  WebView1
//
//  Created by liuningbo on 2021/3/1.
//

#import "UIWebViewJSExportController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@protocol OCJSExport <JSExport>
- (void)loginIn;
- (void)loginSucceed:(NSString *)token;
JSExportAs(jsToOc,- (void)jsToOc:(NSString *)action params:(NSString *)params);

@end


@interface UIWebViewJSExportController ()

@end

@implementation UIWebViewJSExportController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.url = @"UIWebView-JSExport";
    
}
#pragma mark -- OC调用JS方法
- (void)login
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        [context[@"ocToJs"] callWithArguments:@[@"loginSucceed",@"oc_tokenString"]];
    });
}
#pragma mark -- JSExport functions

//! OCJSBridge.login()

-(void) loginIn {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self login];
    });
}
//! OCJSBridge.loginSucceed(token)
- (void)loginSucceed:(NSString *)token
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showAlertWithTitle:@"loginSucceed" message:token cancelHandler:^{
            
        }];
    });
}

- (void) jsToOc:(NSString *)action params:(NSString *)params
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showAlertWithTitle:action message:params cancelHandler:^{
            
        }];
    });
}


@end
