//
//  XTDataLayer.h
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^XTDataLayerBlock)(NSData *date , NSError *error);

@interface XTDataLayer : NSObject

+ (void)shareNewsListDataWithURL:(NSURL *)url completionHandle:(XTDataLayerBlock)block;

+ (NSData *)shareNewsListDataWithURL:(NSURL *)url;

@end
