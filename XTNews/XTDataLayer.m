//
//  XTDataLayer.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTDataLayer.h"

@implementation XTDataLayer

+ (void)shareNewsListDataWithURL:(NSURL *)url completionHandle:(XTDataLayerBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:5];
        
        NSError *error;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        if (block) {
            
            block (data , error);
        }
    });
}

+ (NSData *)shareNewsListDataWithURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:5];
    
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    return (error ? nil : data);
}

@end
