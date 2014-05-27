//
//  XTListView.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTListView.h"

//新闻
#import "XTTableViewCell.h"
#import "XTModelHandle.h"
#import "XTNewsURL.h"


//图片
#import "PSCollectionView.h"
#import "XTCollectionViewCell.h"
#import "BDPictureURL.h"
#import "BDPicModelHandle.h"


#import "XTRefreshView.h"


typedef enum {
    
    RefreshStateNormal = 0,
    
    RefreshStateLoading = 1,
    
    RefreshStatePulling = 2
    
}RefreshState;


@interface XTListView ()
<
UITableViewDelegate,
UITableViewDataSource,
PSCollectionViewDataSource,
PSCollectionViewDelegate,
UIScrollViewDelegate
>

@property (nonatomic , strong) UITableView *contentTableView;

@property (nonatomic , strong) PSCollectionView *contentCollectionView;

@property (nonatomic , strong) NSMutableArray *dataSource;

//----------------------------------------Sep

@property (nonatomic) NSString *key;

//-----------------------------------------

@property (nonatomic , strong) XTRefreshView *refreshView;

@property (nonatomic) RefreshState refreshState;

@end

@implementation XTListView

- (id)initWithFrame:(CGRect)frame
{
    return nil;
}

- (id)initWithFrame:(CGRect)frame type:(XTListViewType)type
{
    if (self = [super initWithFrame:frame]) {
        
        _currentPageNumber = 0;
        
        _type = type;
        
        _dataSource = @[].mutableCopy;
        
        _refreshState = RefreshStateNormal;
        
        [self addContentView];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame keyWord:(NSString *)aKey
{
    if (self = [self initWithFrame:frame type:XTListViewTypeCollectionCell]) {
        
        _currentPageNumber = 0;
        
        _key = aKey;
        
        [self downloadBDPicWithPageNumber:0 keyWord:_key];

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
                collectionView.delegate = self;
                collectionView.backgroundColor = [UIColor whiteColor];
                [self addSubview:collectionView];
                collectionView;
            });
            break;
        }
        default:
            break;
    }
}

- (void)addFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, 10, 260, 40);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    if (_type == XTListViewTypeCollectionCell) {
        
        [_contentCollectionView setFooterView:view];
        
    }else if (_type == XTListViewTypeTableViewCell) {
        
        [_contentTableView setTableFooterView:view];
    }
}

- (void)loadMore
{
    _currentPageNumber++;
    
    if (_type == XTListViewTypeCollectionCell) {
        
        [self downloadBDPicWithPageNumber:_currentPageNumber keyWord:_key];
        
    }else if (_type == XTListViewTypeTableViewCell) {
        
        [self downloadNewsData];
    }
}

- (void)loadCollectionViewWithKeyWord:(NSString *)aKey
{
    if (_type == XTListViewTypeTableViewCell) {
        
        [self.contentTableView setContentOffset:CGPointMake(0, 0)];
        
    }else if (_type == XTListViewTypeCollectionCell) {
        
        [self.contentCollectionView setContentOffset:CGPointMake(0, 0)];
    }
    
    _key = aKey;
    
    [_dataSource removeAllObjects];
    
    [self downloadBDPicWithPageNumber:0 keyWord:aKey];
}

- (void)downloadNewsData
{
    __weak typeof(self) weakSelf = self;
    
    [XTModelHandle shareNewsWithURL:[XTNewsURL shareNewsURLWithType:NewsTypeHeadline pageNumber:_currentPageNumber] completionHandle:^(NSArray *array) {
        
        [weakSelf reloadListViewDataSource:array];
        
    }];
}

- (void)downloadBDPicWithPageNumber:(int)pageNum keyWord:(NSString *)key
{
    //接口不稳定需要多请求2次
    
    static int tryCount = 1;
    
    _key = key;
    
    NSURL *url = [NSURL URLWithString:[BDPictureURL pictureURLWithKeyWord:key PageNum:pageNum]];
    
    __weak typeof(self) weakSelf = self;
    
    [BDPicModelHandle sharePicturesWithURL:url completionHandle:^(NSArray *array, NSError *error) {
        
        if (error) {
            
            if (error.code == HandleErrorTypeHasNoResult && tryCount < 3) {
                
                tryCount ++;
                
                if (tryCount == 2) {
                    
                    DLog(@"重新请求");
                    
                    [self downloadBDPicWithPageNumber:pageNum keyWord:key];
                    
                }else{
                    
                    DLog(@"+图后重新请求");
                    
                    [self downloadBDPicWithPageNumber:pageNum keyWord:[key stringByAppendingString:@"图"]];
                }
    
            }else{
                
                tryCount = 1;
                
                DLog(@"获取图片失败");
            }
            
        }else{
            
            tryCount = 1;
            
            [weakSelf reloadListViewDataSource:array];
            
        }
    }];
}

- (void)reloadListViewDataSource:(NSArray *)array
{
    [_dataSource addObjectsFromArray:array];
    
    if (_type == XTListViewTypeTableViewCell) {
        
        [self.contentTableView reloadData];
        
    }else if (_type == XTListViewTypeCollectionCell) {
        
        [self.contentCollectionView reloadData];
    }
    [self addFooterView];
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
                
        static NSString *CellIdentify = @"Cell";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
            
            cell.backgroundColor = [UIColor lightGrayColor];
            
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
    XTCollectionViewCell *cell = (XTCollectionViewCell *)[collectionView dequeueReusableViewForClass:[XTCollectionViewCell class]];
    if (!cell) {
        cell = [[XTCollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    [cell collectionView:collectionView fillCellWithObject:_dataSource[index] atIndex:index];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return [XTCollectionViewCell rowHeightForObject:_dataSource[index] inColumnWidth:collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    id object = _dataSource[index];
    DLog(@"%@",[object valueForKey:@"origionURL"]);
}

- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index
{
    return [XTCollectionViewCell class];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_type == XTListViewTypeTableViewCell) return;//暂不为tableView添加刷新

    if (decelerate && scrollView.contentOffset.y < -40) {
        
        _refreshState = RefreshStateLoading;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [scrollView setContentInset:UIEdgeInsetsMake(40, 0, 0, 0)];
            
        } completion:^(BOOL finished) {
            
            [_refreshView startAnimation];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [_refreshView endAnimation];
                
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                
                [UIView animateWithDuration:0.3 delay:0.5 options:0 animations:^{
                    
                    [scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                    
                    [_refreshView setAlpha:0];
                    
                } completion:^(BOOL finished) {
                    
                    [_refreshView removeFromSuperview];
                    
                    _refreshView = nil;
                    
                    _refreshState = RefreshStateNormal;
                    
                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                }];
            });
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_type == XTListViewTypeTableViewCell) return;//暂不为tableView添加刷新
    
    if (scrollView.contentOffset.y <= 0 && _refreshState != RefreshStateLoading) {
        _refreshState = RefreshStatePulling;
        if (!_refreshView) {
            _refreshView = [[XTRefreshView alloc] initWithFrame:CGRectMake(100, 5, 125, 25)];
            [_refreshView setProgress:0];
            [self insertSubview:_refreshView atIndex:0];
        }else{
            float f = -scrollView.contentOffset.y / 40;
            [_refreshView setProgress:f > 1 ? 1 : f];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(listView:didSelected:)]) {
        [_delegate listView:self didSelected:indexPath.row];
    }
}

@end
