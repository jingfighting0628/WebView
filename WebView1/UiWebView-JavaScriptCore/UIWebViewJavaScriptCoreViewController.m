//
//  UIWebViewJavaScriptCoreViewController.m
//  WebView1
//
//  Created by liuningbo on 2021/2/28.
//

#import "UIWebViewJavaScriptCoreViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface UIWebViewJavaScriptCoreViewController ()

@end

@implementation UIWebViewJavaScriptCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIWebViewJavaScriptCore";
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"UIWebView-JavaScriptCore" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
    
}
-(void)login
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
       
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        //! JSContext -evaluateScript:方式调用JS方法
        // [context evaluateScript:[NSString stringWithFormat:@"ocToJs('loginSucceed', 'oc_tokenString')"]];
        //! JSValue -callWithArguments:方式调用JS方法
        [context[@"ocToJs"] callWithArguments:@[@"LoginSucceed",@"oc_tokenString"]];
        
        
    });
    
    
}
// 使用context监听JS方法
- (void)addActionWithContext:(JSContext *)context {
    
    [context setExceptionHandler:^(JSContext *context, JSValue *exception) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"JS Exception :%@",exception.toString);
        });
    }];
    
    context[@"jsToOc"] = ^(NSString *action,NSString *params){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertWithTitle:action message:params cancelHandler:^{
                
            }];
            
        });
    };
    
}
#pragma mark - UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.title = [context evaluateScript:@"document.title"].toString;
    
    [self addActionWithContext:context];
}



@end
