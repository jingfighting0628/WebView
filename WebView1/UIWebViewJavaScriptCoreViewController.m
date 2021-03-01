//
//  UIWebViewJavaScriptCoreViewController.m
//  WebView1
//
//  Created by liuningbo on 2021/2/28.
//

#import "UIWebViewJavaScriptCoreViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface UIWebViewJavaScriptCoreViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation UIWebViewJavaScriptCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //_webView.backgroundColor = [UIColor blueColor];
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"UIWebView-JavaScriptCore" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
    
}
-(void)login
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
       
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
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

- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message cancelHandler:(void(^)(void))handler
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

@end
