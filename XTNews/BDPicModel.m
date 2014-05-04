//
//  BDPicModel.m
//  PicDownload
//
//  Created by tage on 14-5-4.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "BDPicModel.h"

@implementation BDPicModel

+ (instancetype)shareWithDic:(NSDictionary *)dictionary
{
    BDPicModel *model = [[BDPicModel alloc] init];
    model.width = [dictionary objectForKey:@"width"];
    model.height = [dictionary objectForKey:@"height"];
    model.thumbURL = [dictionary objectForKey:@"thumburl2"];
    model.origionURL = [dictionary objectForKey:@"objurl"];
    model.title = [dictionary objectForKey:@"frompagetitle"];
    model.size = [dictionary objectForKey:@"size"];
    model.type = [dictionary objectForKey:@"type"];
    return model;
}

+ (NSArray *)picModelArrayWithDic:(NSDictionary *)dictionary
{
    NSMutableArray *array = @[].mutableCopy;
    NSArray *subArray = [dictionary objectForKey:@"data"];
    for (NSDictionary *dic in subArray) {
        BDPicModel *model = [BDPicModel shareWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end
