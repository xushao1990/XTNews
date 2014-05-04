//
//  NSString+Extension.h
//  CocoapodTest
//
//  Created by tage on 14-4-9.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString*) MD5;

- (NSString*) SHA1;

- (NSString*) SHA256;

/**
 *  采用SDWebImage对图片url地址进行编码的格式
 *
 */

- (NSString *)cachedFileName;

/**
 *  是否含有Emoji
 *
 */

- (BOOL)containsEmoji;

/**
 *  是否含有特殊字符 
 *
 *  输入汉字时，如果没有选择汉字直接点击搜索会有特殊字符在获取到的字符串中
 *
 */

- (BOOL)containsSpecialChar;

/**
 *  去除特殊字符
 *
 */

- (NSString *)deleteSpecialChar;

@end
