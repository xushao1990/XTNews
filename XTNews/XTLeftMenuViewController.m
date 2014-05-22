//
//  XTLeftMenuViewController.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTLeftMenuViewController.h"
#import "UIViewController+RESideMenu.h"
#import "RESideMenu.h"
#import "XTCenterViewController.h"

@interface XTLeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataSource;
}
@end

@implementation XTLeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = @[@"第一个viewController",@"第二个viewController"];
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kIOS7DIS(64), 320, CGRectGetHeight(self.view.frame) - kIOS7DIS(64)) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIden = @"CC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIden];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //关闭leftmene
    [self.sideMenuViewController hideMenuViewController];
    
    //取到centerViewController并跳转到响应的viewController
    XTCenterViewController *center = (XTCenterViewController *)self.sideMenuViewController.contentViewController;
    [center selecteViewControllerWithIndex:indexPath.row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
