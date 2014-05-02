//
//  XTListView.h
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

/**
 *  数据列表视图
 */

#import <UIKit/UIKit.h>

/**
 *  扩展展示类型
 */
typedef enum {
    
    XTListViewTypeTableViewCell,
    
    XTListViewTypeCollectionCell
    
}XTListViewType;

@interface XTListView : UIView

- (id)initWithFrame:(CGRect)frame type:(XTListViewType)type;

@end
