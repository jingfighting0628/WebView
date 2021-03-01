//
//  BaseViewController.h
//  WebView1
//
//  Created by liuningbo on 2021/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) UIWebView *webView;
- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message cancelHandler:(void(^)(void))handler;
@end

NS_ASSUME_NONNULL_END
