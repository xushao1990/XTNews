//
//  ListViewDateSource.m
//  MTLL
//
//  Created by tage on 14-4-21.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "ListViewDateSource.h"

typedef enum {
    
    ListViewDateSourceTypeTableView = 0,
    
    ListViewDateSourceTypeCollectionView = 1
    
}ListViewDateSourceType;

@interface ListViewDateSource ()

@property (nonatomic) ListViewCellType type;

@property (nonatomic , strong) NSArray *items;

@property (nonatomic , copy) NSString *cellClassName;

@property (nonatomic , copy) ListViewDataSourceBlock dataSourceBlock;

@end

@implementation ListViewDateSource

- (id)initWithItems:(NSArray *)aItems
     cellIdentifier:(NSString *)aCellIdentifier
               type:(ListViewCellType)aType
 configureCellBlock:(ListViewDataSourceBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.items = aItems;
        self.cellClassName = aCellIdentifier;
        self.type = aType;
        self.dataSourceBlock = aConfigureCellBlock;
    }
    return self;
}

- (void)reloadDatasource:(NSArray *)array completionHandle:(ReloadDataSourceBlock)block
{
    self.items = array;
    
    if (block) {
        
        block();
    }
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    
    return _items[(NSUInteger)indexPath.row];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLog(@"%lu",(unsigned long)_items.count);
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:_cellClassName];
    
    if (!cell) {
        
        DLog();
        
        cell = [[NSClassFromString(_cellClassName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellClassName];
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if (_dataSourceBlock) {
        
        _dataSourceBlock(cell , item , indexPath.row);
    }
    
    return cell;
}

#pragma mark - CollectionViewDataSource

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return _items.count;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    id item = self.items[index];
    Class identifier = NSClassFromString(_cellClassName);
    id cell = [collectionView dequeueReusableViewForClass:identifier];
    if (!cell) {
        cell = [[NSClassFromString(_cellClassName) alloc] init];
    }
    _dataSourceBlock(cell , item , index);
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    id item = self.items[index];
    
    CGFloat height = [NSClassFromString(_cellClassName) rowHeightForObject:item inColumnWidth:collectionView.colWidth];
    
    return height;
}

- (void)dealloc
{
    DLog();
}

@end
