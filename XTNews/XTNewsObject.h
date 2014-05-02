//
//  XTNewsObject.h
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//


/**
 *  Model类，网易新闻新闻种类较多，挑出了几个典型的，写的比较乱
 *
 */


#import <Foundation/Foundation.h>

@interface XTNewsObject : NSObject

@property (nonatomic) NSString *title ,*imageSRC ,*replyCount;

+ (instancetype)shareNewsObjectWithDictionary:(NSDictionary *)dic;

@end


/**
 *  banner对象
 */

@interface XTNewsHeaderObject : XTNewsObject

@end

/**
 *  图集新闻对象 ---- 展示3张图片
 */

@interface XTNewsAtlasObject : XTNewsObject

@property (nonatomic) NSString *firstImageURL ,*secondImageURL ,*thirdImageURL;

@end

/**
 *  默认新闻对象
 */

@interface XTNewsDefaultObject : XTNewsObject

@property (nonatomic) NSString *digest;

@end

/**
 *  默认类型图集新闻对象 ---- 右下角为图集
 */

@interface XTNewsDefaultAtlasObject : XTNewsDefaultObject


@end

/**
 *  默认类型专题新闻对象 ---- 右下角为专题
 */

@interface XTNewsDefaultSpecialObject : XTNewsDefaultObject

@end

/**
 *  默认类型带标签的新闻对象 ---- 右下角为TAG名字
 */

@interface XTNewsDefaultTagObject : XTNewsDefaultObject

@property (nonatomic) NSString *tag;

@end