//
//  AddViewController.m
//  testAutolayout
//
//  Created by Антон Погремушкин on 12.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import "AddViewController.h"
#import "DataBase.h"
#import "Link.h"

@interface AddViewController ()

@property (nonatomic, retain) UITextField *textTitleViewName;
@property (nonatomic, retain) UITextField *textTitleViewURL;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *add =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                    target:self
                                                    action:@selector(addInDataBase)];
    self.navigationItem.rightBarButtonItem = add;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textTitleViewName = [self addTextTitleName];
    self.textTitleViewURL = [self addTextTitleURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) addInDataBase{
    NSString *name = self.textTitleViewName.text;
    NSURL *URL =  [[NSURL alloc] initWithString:self.textTitleViewURL.text];
    
    [self.delegate controller:self didSaveItemWithName:name andURL:URL];
    
    Link *link = [Link linkWithUrlAndName:name andURL:URL];
    DataBase *data = [[DataBase alloc] init];
    [data addInDataBase:link];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TEXT VIEW
- (UITextField *)addTextTitleName{
    UITextField *textTitleView = [[UITextField alloc] init];
    [textTitleView setBackgroundColor:[UIColor lightGrayColor]];
    textTitleView.placeholder = @"Введите имя";
    textTitleView.layer.borderColor = [[UIColor redColor]CGColor];
    textTitleView.layer.borderWidth = 1.0f;
    textTitleView.layer.cornerRadius = 5.0f;
    textTitleView.frame = CGRectMake(30, 100, 260, 40);
    //self.navigationItem.titleView = textTitleView;
    
    [self.view addSubview:textTitleView];
    return textTitleView;
}

- (UITextField *)addTextTitleURL{
    UITextField *textTitleView = [[UITextField alloc] init];
    [textTitleView setBackgroundColor:[UIColor lightGrayColor]];
    textTitleView.placeholder = @"Введите URL";
    textTitleView.layer.borderColor = [[UIColor redColor]CGColor];
    textTitleView.layer.borderWidth = 1.0f;
    textTitleView.layer.cornerRadius = 5.0f;
    textTitleView.frame = CGRectMake(30, 200, 260, 40);
    //self.navigationItem.titleView = textTitleView;
    
    [self.view addSubview:textTitleView];
    return textTitleView;
}




@end
