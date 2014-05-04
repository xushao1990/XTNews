//
//  XTCollectionViewCell.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTCollectionViewCell.h"
#import "BDPicModel.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface XTCollectionViewCell ()

@property (nonatomic , strong) UIImageView *showImageView;

//@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation XTCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 3;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;

        self.clipsToBounds = YES;
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_showImageView];
        
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _titleLabel.backgroundColor = [UIColor colorWithRed:216 / 255.0 green:216 / 255.0 blue:216 / 255.0 alpha:1.0];
//        _titleLabel.numberOfLines = 0;
//        _titleLabel.font = [UIFont systemFontOfSize:12];
//        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.object = nil;
    [_showImageView setImage:nil];
    [_showImageView setFrame:CGRectZero];
//    [_titleLabel setFrame:CGRectZero];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    BDPicModel *model = self.object;
    [_showImageView setFrame:CGRectMake(0, 0, 145,[model.height floatValue] / [model.width floatValue] * 145)];
    
    [_showImageView setImageWithURL:[NSURL URLWithString:model.thumbURL] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
 
}

+ (CGFloat)rowHeightForObject:(id)object inColumnWidth:(CGFloat)columnWidth
{
    BDPicModel *model = object;

    return [model.height floatValue] / [model.width floatValue] * 145;
}
@end
