//
//  XTTabBarViewController.h
//  TabBarViewControllerTest
//
//  Created by tage on 14-4-11.
//  Copyright (c) 2014年 XT. All rights reserved.
//

/**
 *  一个类TabBarViewController
 *
 */

#import <UIKit/UIKit.h>

@interface XTTabBarViewController : UIViewController

@property(nonatomic , weak , readonly) UIViewController *selectedViewController;

@property(nonatomic ,readonly) NSUInteger selectedIndex;

- (void)setViewControllers:(NSArray *)viewControllers;

- (void)selecteViewControllerWithIndex:(NSInteger)index;

@end
