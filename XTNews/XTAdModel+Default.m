//
//  XTAdModel+Default.m
//  XTNews
//
//  Created by fengyulong on 14-7-7.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTAdModel+Default.h"

@implementation XTAdModel (Default)

+ (NSArray *)defaultAdModels
{
    
    NSMutableArray *array = @[].mutableCopy;
    array[0] = [XTAdModel firstModel];
    array[1] = [XTAdModel secondModel];
    array[2] = [XTAdModel thirdModel];
    array[3] = [XTAdModel forthModel];
    return array;
}

+ (instancetype)firstModel
{
    XTAdModel *model = [[XTAdModel alloc] init];
    model.adTitle = @"第一个";
    model.adImageURL = @"http://img6.cache.netease.com/3g/2014/7/7/2014070710051808935.jpg";
    return model;
}

+ (instancetype)secondModel
{
    XTAdModel *model = [[XTAdModel alloc] init];
    model.adTitle = @"第二个";
    model.adImageURL = @"http://img6.cache.netease.com/3g/2014/7/7/2014070710051808935.jpg";
    return model;
}

+ (instancetype)thirdModel
{
    XTAdModel *model = [[XTAdModel alloc] init];
    model.adTitle = @"第三个";
    model.adImageURL = @"http://img6.cache.netease.com/3g/2014/7/7/2014070710051808935.jpg";
    return model;
}

+ (instancetype)forthModel
{
    XTAdModel *model = [[XTAdModel alloc] init];
    model.adTitle = @"第四个";
    model.adImageURL = @"http://img6.cache.netease.com/3g/2014/7/7/2014070710051808935.jpg";
    return model;
}

+ (instancetype)fifthModel
{
    XTAdModel *model = [[XTAdModel alloc] init];
    model.adTitle = @"第五个";
    model.adImageURL = @"http://img6.cache.netease.com/3g/2014/7/7/2014070710051808935.jpg";
    return model;
}


@end
