//
//  AddViewController.h
//  testAutolayout
//
//  Created by Антон Погремушкин on 12.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddViewControllerDelegate;
@interface AddViewController : UIViewController
@property (weak) id<AddViewControllerDelegate> delegate;
@end

@protocol AddViewControllerDelegate <NSObject>
-(void)controller:(AddViewController *)controller didSaveItemWithName:(NSString *)name andURL:(NSURL *)URL;
@end
