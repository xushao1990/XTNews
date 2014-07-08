//
//  XTAdViewItem.m
//  XTNews
//
//  Created by fengyulong on 14-7-7.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTAdViewItem.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface XTAdViewItem ()

@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UILabel *adTitleLabel;

@end

@implementation XTAdViewItem

- (UIImageView *)adImageView
{
    if (!_adImageView) {
        _adImageView = ({
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:self.bounds];
            imageView;
        });
    }
    return _adImageView;
}

#define kTitleLabelHeight (30)

- (UILabel *)adTitleLabel
{
    if (!_adTitleLabel) {
        _adTitleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - kTitleLabelHeight, CGRectGetWidth(self.bounds), kTitleLabelHeight)];
            label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            label;
        });
    }
    return _adTitleLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.adImageView];
        [self addSubview:self.adTitleLabel];
    }
    return self;
}

- (void)setModel:(XTAdModel *)model
{
    _model = model;     
    [self.adImageView setImageWithURL:[NSURL URLWithString:self.model.adImageURL]];
    self.adTitleLabel.text = self.model.adTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
