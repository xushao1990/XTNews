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

@class XTListView;

@protocol XTListViewDelegate <NSObject>

- (void)listView:(XTListView *)listView didSelected:(NSInteger)index;

@end


@interface XTListView : UIView

@property (nonatomic) XTListViewType type;

@property (nonatomic) int currentPageNumber;

@property (nonatomic , weak) id <XTListViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame type:(XTListViewType)type;

- (instancetype)initWithFrame:(CGRect)frame keyWord:(NSString *)aKey;

//下载图片数据

- (void)loadCollectionViewWithKeyWord:(NSString *)aKey;

//下载网易新闻的数据

- (void)downloadNewsData;

@end
