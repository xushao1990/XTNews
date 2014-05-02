//
//  XTModelHandle.h
//  XTNews
//
//  Created by tage on 14-5-1.
//  Copyright (c) 2014年 XT. All rights reserved.
//

/**
 *  用来将下载到的Data转化为model数组
 *
 */


#import <Foundation/Foundation.h>
#import "XTNewsObject.h"
#import "XTDataLayer.h"

typedef void(^XTModelHandleBlock)(NSArray *array);

@interface XTModelHandle : NSObject

+ (void)shareNewsWithURL:(NSURL *)url completionHandle:(XTModelHandleBlock)block;

@end
