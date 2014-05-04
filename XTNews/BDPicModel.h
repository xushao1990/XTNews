//
//  BDPicModel.h
//  PicDownload
//
//  Created by tage on 14-5-4.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPicModel : NSObject

@property (nonatomic) NSString *thumbURL , *origionURL , *width , *height , *size , *type , *title;

+ (instancetype)shareWithDic:(NSDictionary *)dictionary;

+ (NSArray *)picModelArrayWithDic:(NSDictionary *)dictionary;

@end
