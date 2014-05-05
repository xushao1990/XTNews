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

@interface XTCenterFirstViewController ()<iCarouselDataSource,iCarouselDelegate>

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
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _titleArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    XTListView *listView = nil;
    
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        listView = [[XTListView alloc] initWithFrame:view.bounds type:XTListViewTypeCollectionCell];
        listView.tag = 1;
        [view addSubview:listView];
        
    }else{
        
        listView = (XTListView *)[view viewWithTag:1];
    }
    
    [listView loadCollectionViewWithKeyWord:_titleArray[index]];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
