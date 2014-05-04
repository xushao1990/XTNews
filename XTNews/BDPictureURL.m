//
//  BDPictureURL.m
//  XTNews
//
//  Created by tage on 14-5-4.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "BDPictureURL.h"

#define BASICKURL @"http://m.baidu.com/img?tn=bdjsonapp&change=1&word="
#define PAGENUM @"&pn="
#define RNUMBER @"&rn="
#define PERPAGEPICCOUNT (40)

@implementation BDPictureURL

+ (NSString *)pictureURLWithKeyWord:(NSString *)key PageNum:(int)pageNumber
{
    return [BASICKURL stringByAppendingFormat:@"%@%@%d%@%d",[XTURLHelper URLencode4UTF8:key],PAGENUM,pageNumber * PERPAGEPICCOUNT,RNUMBER,PERPAGEPICCOUNT];
}


@end
