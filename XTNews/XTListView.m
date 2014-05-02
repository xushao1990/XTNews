//
//  XTListView.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTListView.h"
#import "PSCollectionView.h"
#import "XTTableViewCell.h"
#import "XTCollectionViewCell.h"

#import "XTModelHandle.h"
#import "XTNewsURL.h"

#import "UIImageView+WebCache.h"

@interface XTListView ()<UITableViewDelegate,UITableViewDataSource,PSCollectionViewDataSource,PSCollectionViewDelegate>

@property (nonatomic) XTListViewType type;

@property (nonatomic , strong) UITableView *contentTableView;

@property (nonatomic , strong) PSCollectionView *contentCollectionView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation XTListView

- (id)initWithFrame:(CGRect)frame
{
    return nil;
}

- (id)initWithFrame:(CGRect)frame type:(XTListViewType)type
{
    if (self = [super initWithFrame:frame]) {
        
        _type = type;
        
        _dataSource = @[].mutableCopy;
        
        [self addContentView];
        
        __weak typeof(self) weakSelf = self;
        
        [XTModelHandle shareNewsWithURL:[XTNewsURL shareNewsURLWithType:NewsTypeHeadline pageNumber:0] completionHandle:^(NSArray *array) {
           
            [weakSelf reloadListViewDataSource:array];
            
        }];
    }
    return self;
}

- (void)addContentView
{
    switch (_type) {
        case XTListViewTypeTableViewCell:
        {
            _contentTableView = ({
                UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
                tableView.delegate = self;
                tableView.dataSource = self;
                [self addSubview:tableView];
                tableView;
            });
            break;
        }
        case XTListViewTypeCollectionCell:
        {
            _contentCollectionView = ({
                PSCollectionView *collectionView = [[PSCollectionView alloc] initWithFrame:self.bounds];
                collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                collectionView.alwaysBounceVertical = YES;
                collectionView.numColsPortrait = 2;
                collectionView.collectionViewDataSource = self;
                collectionView.collectionViewDelegate = self;
                [self addSubview:collectionView];
                collectionView;
            });
            break;
        }
        default:
            break;
    }
}

- (void)reloadListViewDataSource:(NSArray *)array
{
    [_dataSource addObjectsFromArray:array];
    
    if (_type == XTListViewTypeTableViewCell) {
        
        [self.contentTableView reloadData];
        
    }else if (_type == XTListViewTypeCollectionCell) {
        
        [self.contentCollectionView reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_dataSource.count) {
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && _dataSource.count) {
        return 1;
    }
    return (_dataSource.count - 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
//        id object = _dataSource[0];
        
        static NSString *CellIdentify = @"Cell";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
            
            cell.backgroundColor = [UIColor lightGrayColor];
            
//            [cell setSeparatorInset:UIEdgeInsetsMake(0, 320, 0, -320)];
        }
                
        return cell;
        
    }else{
        
        id object = _dataSource[indexPath.row + 1];
        
        static NSString *CellIdentify = @"XTCell";
        
        XTTableViewCell *cell = (XTTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentify];
        
        if (!cell) {
            
            cell = [[XTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
            
            if (kIS_IOS7) {
                
                [cell setSeparatorInset:UIEdgeInsetsMake(0, 14, 0, 14)];
            }
        }
        
        [cell fillCellWithObject:object];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 185;
    }
    return [XTTableViewCell rowHeightForObject:_dataSource[indexPath.row + 1]];
}

#pragma mark - PSCollectionViewDataSource

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return _dataSource.count;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    return nil;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 0;
}

@end
