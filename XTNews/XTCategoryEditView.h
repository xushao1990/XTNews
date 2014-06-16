//
//  XTCategoryEditView.h
//  XTNews
//
//  Created by XT on 14-6-16.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTCategoryEditView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *tags;

- (id)initWithFrame:(CGRect)frame catrgories:(NSArray *)array;

- (void)addTag:(NSString *)tag;

@end
