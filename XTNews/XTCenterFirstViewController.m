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
#import "XTCornerButton.h"
#import "XTCategoryEditView.h"
#import "XTAddButton.h"
#import "UIAlertView+RWBlock.h"

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
    
    NSArray *defaultTitles = [[NSUserDefaults standardUserDefaults] arrayForKey:kDefaultCategoryKey];
    if (!defaultTitles){
        defaultTitles = @[@"摄影",@"爱心早餐",@"壁纸",@"动漫",@"海贼王",@"搞笑",@"小清新",@"英式田园风格装修"];
        [[NSUserDefaults standardUserDefaults] setObject:defaultTitles forKey:kDefaultCategoryKey];
    }
    _titleArray = defaultTitles;
    
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
    
    
    XTCornerButton *cornerButton = [XTCornerButton buttonWithType:UIButtonTypeCustom];
    cornerButton.frame = CGRectMake(CGRectGetMaxX(_segmentControl.frame) + 1, CGRectGetMinY(_segmentControl.frame), CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(_segmentControl.frame), CGRectGetHeight(_segmentControl.frame));
    [cornerButton addTarget:self action:@selector(showCategories:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cornerButton];
}


- (void)showCategories:(XTCornerButton *)sender
{
    BOOL show = [sender cornerButtonSelected];
    if (show) {
        [XTSideMenuManager resetSideMenuRecognizerEnable:NO];
        [self showCategoryView];
        [self showAddCategoryButton];
    }else{
        [XTSideMenuManager resetSideMenuRecognizerEnable:YES];
        [self hideCategoryView];
        [self hideAddCategoryButton];
    }
}

- (void)showAddCategoryButton
{
    XTAddButton *addCategoryButton = [XTAddButton buttonWithType:UIButtonTypeCustom];
    addCategoryButton.frame = CGRectMake(10, CGRectGetMinY(_segmentControl.frame) + 3, 80, 30);
    addCategoryButton.alpha = 0;
    addCategoryButton.tag = kTagAddCategoryButton;
    [addCategoryButton addTarget:self action:@selector(addCategory:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addCategoryButton];
    [UIView animateWithDuration:kCategoryShowAnimationTime animations:^{
        addCategoryButton.alpha = 1;
        _segmentControl.alpha = 0;
    }];
}

- (void)addCategory:(UIButton *)button
{
    UIAlertView *inputAlertView = [[UIAlertView alloc] initWithTitle:@"请输入要添加的分类" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"添加", nil];
    inputAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    __weak typeof(self) weakSelf = self;
    [inputAlertView setCompletionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            UITextField *textField = [alertView textFieldAtIndex:0];
            NSString *string = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (string && string.length) {
                [weakSelf addNewTag:string];
            }
        }
    }];
    [inputAlertView show];
}

- (void)addNewTag:(NSString *)tag
{
    UIView *view = [self.view viewWithTag:kTagCategoryBackView];
    XTCategoryEditView *editView = view.subviews[0];
    [editView addTag:tag];
}

- (void)reloadCarousel:(NSArray *)newTags
{
    if (![newTags isEqualToArray:self.titleArray]) {
        NSString *currentCategory = self.titleArray[_carousel.currentItemIndex];
        NSInteger index = [newTags indexOfObject:currentCategory];
        if (index == NSNotFound) {
            index = 0;
        }
        self.titleArray = newTags;
        [self.carousel reloadData];
        [self.carousel scrollToItemAtIndex:index animated:NO];
        [self.segmentControl reloadSegsWithItems:self.titleArray];
        [self.segmentControl selectIndex:index];
        [[NSUserDefaults standardUserDefaults] setObject:self.titleArray forKey:kDefaultCategoryKey];
    }
}

- (void)hideAddCategoryButton
{
    UIView *addCategoryButton = [self.view viewWithTag:kTagAddCategoryButton];
    [UIView animateWithDuration:kCategoryShowAnimationTime animations:^{
        addCategoryButton.alpha = 0;
        _segmentControl.alpha = 1;
    }completion:^(BOOL finished) {
        addCategoryButton.tag = 0;
        [addCategoryButton removeFromSuperview];
    }];
}

- (void)showCategoryView
{
    UIView *categortBackView = [[UIView alloc] initWithFrame:_carousel.frame];
    categortBackView.clipsToBounds = YES;
    categortBackView.backgroundColor = [UIColor clearColor];
    categortBackView.tag = kTagCategoryBackView;
    [self.view addSubview:categortBackView];
    
    XTCategoryEditView *editView = [[XTCategoryEditView alloc] initWithFrame:categortBackView.bounds catrgories:_titleArray];
    editView.center = CGPointMake(editView.center.x, -editView.center.y);
    [categortBackView addSubview:editView];
    
    [UIView animateWithDuration:kCategoryShowAnimationTime animations:^{
        editView.center = CGPointMake(editView.center.x, -editView.center.y);
    }];
}

- (void)hideCategoryView
{
    UIView *view = [self.view viewWithTag:kTagCategoryBackView];
    XTCategoryEditView *editView = view.subviews[0];
    [self reloadCarousel:editView.tags];
    [UIView animateWithDuration:kCategoryShowAnimationTime animations:^{
        editView.center = CGPointMake(editView.center.x, -editView.center.y);
    }completion:^(BOOL finished) {
        view.tag = 0;
        [view removeFromSuperview];
    }];
}

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
        listView = [[XTListView alloc] initWithFrame:view.bounds type:XTListViewTypeCollectionCell];//修改此处的类型
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
