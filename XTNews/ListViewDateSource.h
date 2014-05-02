//
//  ListViewDateSource.h
//  MTLL
//
//  Created by tage on 14-4-21.
//  Copyright (c) 2014年 XT. All rights reserved.
//

/**
 *  此类为实践 轻量化的ViewController，未成功
 *
 */


#import <Foundation/Foundation.h>
#import "ListViewDataSourceHeader.h"
#import "PSCollectionView.h"
#import "PSCollectionViewCell.h"

typedef void (^ListViewDataSourceBlock)(id cell, id item , NSInteger index);

typedef void(^ReloadDataSourceBlock)(void);

@interface ListViewDateSource : NSObject<PSCollectionViewDataSource,UITableViewDataSource>

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
               type:(ListViewCellType)type
 configureCellBlock:(ListViewDataSourceBlock)aConfigureCellBlock;

- (void)reloadDatasource:(NSArray *)array completionHandle:(ReloadDataSourceBlock)block;

@end
