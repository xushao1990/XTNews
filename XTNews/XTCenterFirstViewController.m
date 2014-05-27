//
//  XTCenterFirstViewController.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTCenterFirstViewController.h"
#import "XTListView.h"
#import "iCarousel.h"
#import "XTSegmentControl.h"

@interface XTCenterFirstViewController ()<iCarouselDataSource,iCarouselDelegate,XTListViewDelegate>

@property (nonatomic , strong) XTSegmentControl *segmentControl;

/**
 *  可重用的类scrollview，功能强大
 *
 *  https://github.com/nicklockwood/iCarousel
 */

@property (nonatomic , strong) iCarousel *carousel;

@property (nonatomic , strong) NSArray *titleArray;

@end

@implementation XTCenterFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"XT图片";
    }
    return self;
}

#define kSegMentControlHeight (36)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _titleArray = @[@"摄影",@"爱心早餐",@"壁纸",@"动漫",@"海贼王",@"搞笑",@"小清新",@"英式田园风格装修"];
    
    float listOrigionY = kIOS7DIS(64) + kSegMentControlHeight;
    float listViewHeight = CGRectGetHeight(self.view.bounds) - 44 - kIOS7DIS(20) - kSegMentControlHeight;
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, listOrigionY, 320, listViewHeight)];
    _carousel.backgroundColor = [UIColor whiteColor];
    _carousel.dataSource = self;
    _carousel.delegate = self;
    _carousel.decelerationRate = 0.7;
    _carousel.type = iCarouselTypeLinear;
    _carousel.pagingEnabled = YES;
    _carousel.edgeRecognition = YES;
    _carousel.bounceDistance = 0.4;
    [self.view addSubview:_carousel];
        
    __weak typeof(_carousel) weakCarousel = _carousel;
    
    _segmentControl = [[XTSegmentControl alloc] initWithFrame:CGRectMake(20, kIOS7DIS(64), 260, 36) Items:_titleArray selectedBlock:^(NSInteger index) {
        
        [weakCarousel scrollToItemAtIndex:index animated:NO];
    }];
    
    [self.view addSubview:_segmentControl];
    
    /*
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doPanGes:)];
    [self.view addGestureRecognizer:panGes];
    */
}
/*
- (void)doPanGes:(UIPanGestureRecognizer *)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            DLog();
            break;
        case UIGestureRecognizerStateEnded:
            DLog();
            break;
        default:
            break;
    }
}
 */

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _titleArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
#warning 此处可以定制想要展示的列表
    
#warning 当type为XTListViewTypeCollectionCell时为抓取百度图片的数据，瀑布流展示

#warning 当type为XTListViewTypeTableViewCell时为抓取网易新闻的数据
    
    XTListView *listView = nil;
    
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        listView = [[XTListView alloc] initWithFrame:view.bounds type:XTListViewTypeTableViewCell];//修改此处的类型
        listView.tag = 1;
        listView.delegate = self;
        [view addSubview:listView];
        
    }else{
        
        listView = (XTListView *)[view viewWithTag:1];
    }
    
    listView.currentPageNumber = 0;
    
    if (listView.type == XTListViewTypeCollectionCell) {
        
        [listView loadCollectionViewWithKeyWord:_titleArray[index]];
        
    }else if (listView.type == XTListViewTypeTableViewCell) {
        
        [listView downloadNewsData];
    }
    
    return view;
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    if (_segmentControl) {
        
        float offset = carousel.scrollOffset;
        
        if (offset > 0) {
            
            [_segmentControl moveIndexWithProgress:offset];
        }
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    if (_segmentControl) {
        
        [_segmentControl endMoveIndex:carousel.currentItemIndex];
    }
}

#pragma mark - ListViewDelegate

- (void)listView:(XTListView *)listView didSelected:(NSInteger)index
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    [XTSideMenuManager resetSideMenuRecognizerEnable:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [XTSideMenuManager resetSideMenuRecognizerEnable:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
