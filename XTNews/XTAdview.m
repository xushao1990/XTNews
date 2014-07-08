//
//  XTAdview.m
//  XTNews
//
//  Created by fengyulong on 14-7-7.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTAdview.h"
#import "iCarousel.h"
#import "XTAdViewItem.h"

@interface XTAdview ()<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic, strong) NSMutableArray *currentShowAdDataSource;
@property (nonatomic, strong) NSArray *adDataSource;
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) UIPageControl *control;
@property (nonatomic) NSTimer *timer;

@end

@implementation XTAdview

- (id)initWithFrame:(CGRect)frame ads:(NSArray *)ads
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adDataSource = ads;
        [self setCurrentShowAds];
        self.carousel.dataSource = self;
        [self addSubview:self.carousel];
        [self addSubview:self.control];
        self.control.numberOfPages = self.adDataSource.count;
        [self.carousel scrollToItemAtIndex:self.adDataSource.count animated:NO];
//        [self autoScroll];//调用自动滚动
    }
    return self;
}

#pragma mark - properties

-(iCarousel *)carousel
{
    if (!_carousel) {
        _carousel = ({
            iCarousel *carousel = [[iCarousel alloc] initWithFrame:self.bounds];
            carousel.backgroundColor = [UIColor whiteColor];
            carousel.dataSource = self;
            carousel.delegate = self;
            carousel.decelerationRate = 0.7;
            carousel.type = iCarouselTypeLinear;
            carousel.pagingEnabled = YES;
            carousel.edgeRecognition = YES;
            carousel.bounceDistance = 0.4;
            carousel;
        });
    }
    return _carousel;
}

- (UIPageControl *)control
{
    if (!_control) {
        _control = ({
            UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 100, CGRectGetHeight(self.frame) - 30, 100, 30)];
            pageControl.backgroundColor = [UIColor clearColor];
            pageControl.hidesForSinglePage = YES;
            pageControl.userInteractionEnabled = NO;
            pageControl;
        });
    }
    return _control;
}

- (NSMutableArray *)currentShowAdDataSource
{
    if (!_currentShowAdDataSource) {
        _currentShowAdDataSource = @[].mutableCopy;
    }
    return _currentShowAdDataSource;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.currentShowAdDataSource.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    XTAdViewItem *item;
    if (!view) {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        
        XTAdViewItem *item = [[XTAdViewItem alloc] initWithFrame:view.bounds];
        item.tag = 1;
        [view addSubview:item];
    }
    item = (XTAdViewItem *)[view viewWithTag:1];
    item.model = self.currentShowAdDataSource[(index % self.adDataSource.count)];
    return view;
}

#pragma mark - 核心策略

/**
 *  当广告数量多于1个时会将广告的models重复3次添加到数据源，即分为3块。比如，ABCD|ABCD|ABCD
 *  一直显示最中间的ABCD
 *  当从中间的A滑动到左侧的D后，手动将iCarousel的当前展示的index设置为中间的D，当然是以无动画的形式
 *  同理，当从中间的D滑动到右侧的A后，手动将iCarousel的当前展示的index设置为中间的A，同样是以无动画的形式
 *  这样实现了循环滑动
 */

-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    if (self.adDataSource.count > 1) {
        [self.control setCurrentPage:carousel.currentItemIndex % self.adDataSource.count];
        if (carousel.currentItemIndex < self.adDataSource.count) {
            [carousel scrollToItemAtIndex:carousel.currentItemIndex + self.adDataSource.count animated:NO];
        }
        if (carousel.currentItemIndex > self.adDataSource.count * 2 - 1) {
            [carousel scrollToItemAtIndex:carousel.currentItemIndex - self.adDataSource.count animated:NO];
        }
    }
}

- (void)setCurrentShowAds
{
    if (self.adDataSource.count > 1) {
        [self.currentShowAdDataSource addObjectsFromArray:self.adDataSource];
        [self.currentShowAdDataSource addObjectsFromArray:self.adDataSource];
        [self.currentShowAdDataSource addObjectsFromArray:self.adDataSource];
    }else{
        [self.currentShowAdDataSource addObjectsFromArray:self.adDataSource];
    }
}

#pragma mark 此处实现了自动滚动

/*
- (void)autoScroll
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScrollAd) userInfo:nil repeats:YES];
}

- (void)autoScrollAd
{
    [self.carousel scrollToItemAtIndex:self.carousel.currentItemIndex + 1 animated:YES];
}

- (void)releaseTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

*/
- (void)dealloc
{
    DLog();
}

@end
