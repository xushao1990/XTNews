//
//  XTModelHandle.m
//  XTNews
//
//  Created by tage on 14-5-1.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTModelHandle.h"

@implementation XTModelHandle

+ (void)shareNewsWithURL:(NSURL *)url completionHandle:(XTModelHandleBlock)block
{
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(currentQueue, ^{
       
        __block NSData *requestData;
        
        __block NSMutableArray *parseArray = @[].mutableCopy;
        
        dispatch_group_t handleGroup = dispatch_group_create();
        
        dispatch_semaphore_t parseSemaphore = dispatch_semaphore_create(0);
        
        dispatch_block_t requestTask = ^(){
            
            requestData = [XTDataLayer shareNewsListDataWithURL:url];
                        
            dispatch_semaphore_signal(parseSemaphore);
        };
        
        dispatch_block_t parseTask = ^(){
            
            dispatch_semaphore_wait(parseSemaphore, DISPATCH_TIME_FOREVER);
            
            if (requestData) {
                
                NSError *jsonError;
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:&jsonError];
                
                if (!jsonError) {
                    
                    id object = [dic objectForKey:[dic.allKeys firstObject]];
                    
                    for (NSDictionary *subObject in object) {
                        
                        id newsObject = [XTNewsObject shareNewsObjectWithDictionary:subObject];
                        
                        [parseArray addObject:newsObject];
                    }
                }
            }
        };
        
        dispatch_group_async(handleGroup, currentQueue, requestTask);
        
        dispatch_group_async(handleGroup, currentQueue, parseTask);
        
        dispatch_group_wait(handleGroup, DISPATCH_TIME_FOREVER);
        
        if (block) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                                
                block(parseArray);
            });
        }
    });
}


@end
