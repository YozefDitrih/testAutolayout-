//
//  AppDelegate.m
//  testAutolayout
//
//  Created by Антон Погремушкин on 10.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import "AppDelegate.h"
#import "DataBase.h"
#import "ViewController.h"
#import "TableViewController.h"

@interface AppDelegate ()

@property (readonly) TableViewController *viewController;

@end

@implementation AppDelegate

@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[DataBase shared] migrateDataBase];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window setRootViewController:navigationController];
    
    [self.window makeKeyAndVisible];
    

    return YES;
}

#pragma mark - UI Elements

- (UIWindow *)window{
    if(!_window){
        
        CGRect windowRect = [[UIScreen mainScreen] bounds];
        _window = [[UIWindow alloc] initWithFrame:windowRect];
    }
    return _window;
}

-(TableViewController *)viewController{
    if(!_viewController){
        _viewController = [TableViewController new];
        
    }
    return _viewController;
}


@end
