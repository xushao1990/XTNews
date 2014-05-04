//
//  BDPicModelHandle.m
//  XTNews
//
//  Created by tage on 14-5-4.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "BDPicModelHandle.h"
#import "BDPicModel.h"

@implementation BDPicModelHandle

+ (void)sharePicturesWithURL:(NSURL *)url completionHandle:(BDPicModelHandleBlock)block
{    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSError *error;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:5.0] returningResponse:nil error:&error];
        
        if (!error) {
            
            NSError *jsonError;
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (!jsonError) {
                
                NSArray *array = [BDPicModel picModelArrayWithDic:dic];
                
                if (array.count == 0) {
                    
                    NSError *falseError = [NSError errorWithDomain:@"获取数据为空" code:HandleErrorTypeHasNoResult userInfo:nil];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        block (nil , falseError);
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        block (array , nil);
                    });
                }
                
            }else{
                
                NSError *falseError = [NSError errorWithDomain:@"解析Json出错" code:HandleErrorTypeJsonError userInfo:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    block (nil , falseError);
                });
            }
            
        }else{
            
            NSError *falseError = [NSError errorWithDomain:@"网络访问出错" code:HandleErrorTypeConnectionError userInfo:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (nil , falseError);
            });
        }
    });
}


@end
