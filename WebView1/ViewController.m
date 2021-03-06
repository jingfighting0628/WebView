//
//  ViewController.m
//  WebView1
//
//  Created by liuningbo on 2021/2/26.
//

#import "ViewController.h"
#import "UIWebViewJavaScriptCoreViewController.h"
#import "UIWebViewJSExportController.h"
#import "UiWebViewProtocolinterceptViewController.h"
#import "WKWebViewProtocolinterceptViewController.h"
#import "WKWebViewWKScriptMessageHandlerController.h"
#import "WKWebViewJavaScriptBridgeController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@end

@implementation ViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Native WebView HyBird ";
    _dataSourceArray = @[@"iOS与JS交互UIWebView协议拦截",
    @"使用JavaScriptCore框架",
    @"使用JxEport协议",
    @"WKWebView协议拦截",
    @"WKScriptMessageHandle协议",
    @"WKWebViewJSBridge第三方框架"];
    
    [self setUpTableView];

    
    
}

- (void)setUpTableView
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _dataSourceArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UiWebViewProtocolinterceptViewController *vc = [[UiWebViewProtocolinterceptViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        UIWebViewJavaScriptCoreViewController *vc = [[UIWebViewJavaScriptCoreViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        UIWebViewJSExportController *vc = [[UIWebViewJSExportController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        WKWebViewProtocolinterceptViewController *vc = [[WKWebViewProtocolinterceptViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4)
    {
        WKWebViewWKScriptMessageHandlerController *vc = [[WKWebViewWKScriptMessageHandlerController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        WKWebViewJavaScriptBridgeController *vc = [[WKWebViewJavaScriptBridgeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
