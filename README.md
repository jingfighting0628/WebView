# WebView
展示了五种iOS和JS交互方式
1、UIWebView协议拦截方式
#JS调用OC
在UIWebView的shouldStartLoadWithRequest方法判断URL的scheme是否为js调用oc的方法名，如果是，则获取js传给oc的参数并在这进行操作
#OC调用JS
用UIWebView的实例调用stringByEvaluatingJavaScriptFromString:@"方法名('参数1','参数2',...)"


2、UIWebView使用JavaScriptCore苹果框架
#JS调用OC
在UIWebVie的代理方法webViewDidFinishLoad中
JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
获取JSContext,这是执行JS代码的上下文，
然后
context["方法名"] = ^(‘参数1’，‘参数2’){
  //要执行的代码
}
#OC调用JS
在调用JS触发的方法中，JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
获取JSContext,这是执行JS代码的上下文
//! JSContext -evaluateScript:方式调用JS方法
// [context evaluateScript:[NSString stringWithFormat:@"方法名('参数1', '参数2')"]];
//! JSValue -callWithArguments:方式调用JS方法
[context[@"ocToJs"] callWithArguments:@[@"参数1",@"参数2"]];

3、使用WKWebView协议拦截
#JS调用OC
在WKWebView的decidePolicyForNavigationAction代理方法判断URL的scheme是否为js调用oc的方法名，如果是，则获取js传给oc的参数并在这进行操作
#OC调用JS
用WKWebView的实例调用evaluateJavaScript:@"方法名('参数1','参数2',...)"
4、使用WKScriptMessageHandler协议
#JS调用OC
[self.webView.configuration.userContentController addScriptMessageHandler:self name:@"方法名"]
在userContentController didReceiveScriptMessage代理方法中判断
message.name是否为"方法名"，如果是JS传给OC的参数在message.body中
#OC调用JS
[self.webView evaluateJavaScript:@"方法名('参数1','参数2')" completionHandler:nil]


5、使用第三方框架WKWebViewJSBridge(UIWebView)
#JS调用OC
[self.bridge registerHandler:@"方法名" handler:^(id data, WVJBResponseCallback responseCallback) {
 
   NSArray *arr = data;
    其中data为JS传给OC的参数
    
}]

#OC调用JS
[self.bridge callHandler:@"方法名" data:@[@"参数1", @"参数2"] responseCallback:^(id responseData) {
    NSLog(@"responseData :%@",responseData);
}];
