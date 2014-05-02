//
//  XTRootViewController.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTRootViewController.h"
#import "CRNavigationController.h"
#import "CRNavigationBar.h"
#import "XTCenterViewController.h"
#import "XTLeftMenuViewController.h"
#import "XTRightMenuViewController.h"
#import "XTCenterFirstViewController.h"
#import "XTCenterSecondViewController.h"


@interface XTRootViewController ()

@end

@implementation XTRootViewController

+ (instancetype)rootViewController
{
    XTCenterFirstViewController *first = [[XTCenterFirstViewController alloc] init];
    XTCenterSecondViewController *second = [[XTCenterSecondViewController alloc] init];
    
    XTCenterViewController *center = [[XTCenterViewController alloc] init];
    [center setViewControllers:@[[XTRootViewController nav:first],[XTRootViewController nav:second]]];
    
    XTLeftMenuViewController *leftMenu = [[XTLeftMenuViewController alloc] init];
    
    XTRightMenuViewController *rightMenu = [[XTRightMenuViewController alloc] init];
    
    XTRootViewController *sideMenuViewController = [[XTRootViewController alloc] initWithContentViewController:center leftMenuViewController:leftMenu rightMenuViewController:rightMenu];
    
    sideMenuViewController.panFromEdge = NO;
    
    sideMenuViewController.scaleMenuView = NO;
    
    sideMenuViewController.scaleBackgroundImageView = NO;
    
    sideMenuViewController.menuViewOpacity = NO;
    
    return sideMenuViewController;
}

+ (UINavigationController *)nav:(UIViewController *)sender
{
    //用来调节navgationBar颜色的
    
    //reference：http://www.cocoachina.com/applenews/devnews/2013/1024/7233.html
    
    CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:sender];
    CRNavigationBar *navigationBar = (CRNavigationBar *)nav.navigationBar;
    [navigationBar displayColorLayer:YES];
    navigationBar.barTintColor = [UIColor colorWithRed:0.776471 green:0.196078 blue:0.207843 alpha:1.0];
    return nav;
}

@end
