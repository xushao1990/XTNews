//
//  XTTableViewCell.h
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTTableViewCell : UITableViewCell

/**
 *  填充cell的对象
 *
 */

- (void)fillCellWithObject:(id)object;

/**
 *  计算cell高度
 *
 */

+ (CGFloat)rowHeightForObject:(id)object;

@end
