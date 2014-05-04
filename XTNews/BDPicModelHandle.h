//
//  BDPicModelHandle.h
//  XTNews
//
//  Created by tage on 14-5-4.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    
    HandleErrorTypeHasNoResult = 100,
    
    HandleErrorTypeConnectionError = 101,
    
    HandleErrorTypeJsonError = 102
    
}HandleErrorType;

typedef void(^BDPicModelHandleBlock)(NSArray *array , NSError *error);

@interface BDPicModelHandle : NSObject

+ (void)sharePicturesWithURL:(NSURL *)url completionHandle:(BDPicModelHandleBlock)block;

@end
