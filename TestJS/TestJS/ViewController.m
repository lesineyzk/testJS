//
//  ViewController.m
//  TestJS
//
//  Created by lesiney on 16/8/16.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"resource/testhtml.html" withExtension:nil];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //JS调用OC方法shouldStartLoadWithRequest 方式二
    context[@"jakilllog"] = ^() {
        
        //        NSLog(@"+++++++Begin Log+++++++");
        //        NSArray *args = [JSContext currentArguments];
        //
        //        for (JSValue *jsVal in args) {
        //            NSLog(@"%@", jsVal);
        //        }
        //
        //        JSValue *this = [JSContext currentThis];
        //        NSLog(@"this: %@",this);
        //        NSLog(@"-------End Log-------");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"按钮被点击了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil, nil];
        
        　　[alert show];
    };
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

//JS调用OC方法 方式一
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *path=[[request URL] absoluteString];
    
    NSLog(@"%@",path);
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//OC调用JS
- (IBAction)btn:(id)sender {
    [self.webView stringByEvaluatingJavaScriptFromString:@"alertClick()"];
}


@end
