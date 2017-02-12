//
//  WebViewController.h
//  testAutolayout
//
//  Created by Антон Погремушкин on 10.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (weak, nonatomic) UILabel *lolLabel;
@property (weak, nonatomic) UIWebView *webView;
@property (copy, nonatomic) NSURL *URL;

@end
