//
//  XTNewsURL.m
//  XTNews
//
//  Created by tage on 14-5-1.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTNewsURL.h"

#define kNewsIdentify   @"T1348647853363"
#define kNewsListBasicURL    @"http://c.m.163.com/nc/article/"
//@"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html"

@implementation XTNewsURL

+ (NSURL *)shareNewsURLWithType:(NewsType)type pageNumber:(NSInteger)aPageNumber
{
    NSString *identify = [XTNewsURL identifyWithType:type];
    
    NSString *pageIdentify = [XTNewsURL pageIdentifyWithPageNumber:aPageNumber];
    
    NSString *newsURL = [kNewsListBasicURL stringByAppendingFormat:@"%@/%@/%@.html",identify,kNewsIdentify,pageIdentify];
    
    return [NSURL URLWithString:newsURL];
}

+ (NSString *)identifyWithType:(NewsType)type
{
    switch (type) {
        case NewsTypeHeadline:
            return @"headline";
            break;
        default:
            break;
    }
    return @"headline";
}

+ (NSString *)pageIdentifyWithPageNumber:(NSInteger)aPageNumber
{
    return [NSString stringWithFormat:@"%ld-20",aPageNumber * 20];
}

@end
