//
//  XTSideMenuManager.m
//  XTNews
//
//  Created by tage on 14-5-27.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTSideMenuManager.h"
#import "RESideMenu.h"

@implementation XTSideMenuManager

+ (void)resetSideMenuRecognizerEnable:(BOOL)canOpen
{
    RESideMenu *menu = (RESideMenu *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    menu.panGestureEnabled = canOpen;
}

@end
