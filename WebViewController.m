//
//  WebViewController.m
//  testAutolayout
//
//  Created by Антон Погремушкин on 10.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.webView = [self uiWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIWebView *)uiWebView{
    UIWebView *webView = [[UIWebView alloc] init];
    
    webView.frame = CGRectMake(0, 0, 320, 568);
//    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(self.view);
//        make.top.equalTo(self.mas_topLayoutGuide);
//        make.height.equalTo(webView.mas_width).multipliedBy(9.0f/16.0f);
//    }];
//    
    
    [webView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    [self.view addSubview:webView];
    return webView;
}

@end
