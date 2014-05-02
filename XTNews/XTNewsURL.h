//
//  XTNewsURL.h
//  XTNews
//
//  Created by tage on 14-5-1.
//  Copyright (c) 2014年 XT. All rights reserved.
//

/**
 *  生成请求的URL
 */

#import <Foundation/Foundation.h>

typedef enum {
    
    NewsTypeHeadline
    
    
}NewsType;


@interface XTNewsURL : NSObject

+ (NSURL *)shareNewsURLWithType:(NewsType)type pageNumber:(NSInteger)aPageNumber;

@end
