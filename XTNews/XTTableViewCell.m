//
//  XTTableViewCell.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTTableViewCell.h"
#import "XTNewsObject.h"
#import "UIImageView+WebCache.h"
#import "MCTopAligningLabel.h"

@interface XTTableViewCell ()

@property (nonatomic , strong) id object;

@property (nonatomic , strong) UIImageView *showImageView;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) MCTopAligningLabel *digestLabel;

@property (nonatomic , strong) UILabel *replyCountLabel;

@property (nonatomic , strong) UIImageView *tagImageView;

@property (nonatomic , strong) UIImageView *firstImageView;

@property (nonatomic , strong) UIImageView *secondImageView;

@property (nonatomic , strong) UIImageView *thirdImageView;

@end

@implementation XTTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_showImageView];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        _digestLabel = [[MCTopAligningLabel alloc] initWithFrame:CGRectZero];
        _digestLabel.backgroundColor = [UIColor clearColor];
        _digestLabel.textColor = [UIColor lightGrayColor];
        _digestLabel.numberOfLines = 0;
        _digestLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _digestLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_digestLabel];
        _replyCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _replyCountLabel.backgroundColor = [UIColor clearColor];
        _replyCountLabel.textColor = [UIColor lightGrayColor];
        _replyCountLabel.font = [UIFont systemFontOfSize:12];
        _replyCountLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_replyCountLabel];
        _tagImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_tagImageView];
        
        _firstImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_firstImageView];
        _secondImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_secondImageView];
        _thirdImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_thirdImageView];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _object = nil;
    
    [self resetImageView:_showImageView];
    
    [_titleLabel setFrame:CGRectZero];
    
    [_digestLabel setFrame:CGRectZero];
    
    [_replyCountLabel setFrame:CGRectZero];
    
    [self resetImageView:_tagImageView];
    
    [_tagImageView setBackgroundColor:[UIColor clearColor]];
    
    [self resetImageView:_firstImageView];
    
    [self resetImageView:_secondImageView];
    
    [self resetImageView:_thirdImageView];
}

- (void)resetImageView:(UIImageView *)imageView
{
    [imageView setImage:nil];
    [imageView setFrame:CGRectZero];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.object) {
        
        if ([self.object isMemberOfClass:[XTNewsDefaultObject class]]) {
            
            XTNewsDefaultObject *object = self.object;
            
            [_showImageView setImageWithURL:[NSURL URLWithString:object.imageSRC]];
            
            _showImageView.frame = CGRectMake(13, 10, 70, 51);
            
            _titleLabel.text = object.title;
            
            _titleLabel.frame = CGRectMake(CGRectGetMaxX(_showImageView.frame) + 10, CGRectGetMinY(_showImageView.frame),CGRectGetWidth(self.bounds) - CGRectGetMaxX(_showImageView.frame) - 10, 20);
            
            _digestLabel.text = object.digest;
            
            _digestLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 2, CGRectGetWidth(_titleLabel.frame) - 15, 30);
            
            _replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",[self replyCount:object.replyCount]];
            
            _replyCountLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) - 74, CGRectGetMaxY(_digestLabel.frame) - 15, 60, 15);
            
        }else if ([self.object isMemberOfClass:[XTNewsDefaultTagObject class]]) {
            
            XTNewsDefaultTagObject *object = self.object;
            
            [_showImageView setImageWithURL:[NSURL URLWithString:object.imageSRC]];
            
            _showImageView.frame = CGRectMake(13, 10, 70, 51);
            
            _titleLabel.text = object.title;
            
            _titleLabel.frame = CGRectMake(CGRectGetMaxX(_showImageView.frame) + 10, CGRectGetMinY(_showImageView.frame),CGRectGetWidth(self.bounds) - CGRectGetMaxX(_showImageView.frame) - 10, 20);
            
            _digestLabel.text = object.digest;
            
            _digestLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 2, CGRectGetWidth(_titleLabel.frame) - 15, 30);

            _tagImageView.frame = CGRectMake(CGRectGetWidth(self.bounds) - 34, CGRectGetMaxY(_digestLabel.frame) - 15, 20, 15);
            
            if ([object.tag isEqualToString:@"视频"]) {
                
                [_tagImageView setBackgroundColor:[UIColor redColor]];
                
            }else if ([object.tag isEqualToString:@"独家"]) {
                
                [_tagImageView setBackgroundColor:[UIColor blueColor]];
                
                _replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",[self replyCount:object.replyCount]];
                
                _replyCountLabel.frame = CGRectMake(CGRectGetMinX(_tagImageView.frame) - 65, CGRectGetMinY(_tagImageView.frame), 60, 15);
            }
                        
        }else if ([self.object isMemberOfClass:[XTNewsDefaultSpecialObject class]]) {
            
            XTNewsDefaultSpecialObject *object = self.object;
            
            [_showImageView setImageWithURL:[NSURL URLWithString:object.imageSRC]];
            
            _showImageView.frame = CGRectMake(13, 10, 70, 51);
            
            _titleLabel.text = object.title;
            
            _titleLabel.frame = CGRectMake(CGRectGetMaxX(_showImageView.frame) + 10, CGRectGetMinY(_showImageView.frame),CGRectGetWidth(self.bounds) - CGRectGetMaxX(_showImageView.frame) - 10, 20);
            
            _digestLabel.text = object.digest;
            
            _digestLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 2, CGRectGetWidth(_titleLabel.frame) - 15, 30);
            
            [_tagImageView setBackgroundColor:[UIColor purpleColor]];
            
            _tagImageView.frame = CGRectMake(CGRectGetWidth(self.bounds) - 34, CGRectGetMaxY(_digestLabel.frame) - 15, 20, 15);
            
        }else if ([self.object isMemberOfClass:[XTNewsAtlasObject class]]) {
            
            XTNewsAtlasObject *object = self.object;
            
            _titleLabel.text = object.title;
            
            _titleLabel.frame = CGRectMake(13, 10,CGRectGetWidth(self.bounds) - 12 - 14 - 60, 20);
            
            _replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",[self replyCount:object.replyCount]];

            _replyCountLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) - 74, CGRectGetMinY(_titleLabel.frame) + 5, 60, 15);
            
            _firstImageView.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 8, 88, 63);
            
            [_firstImageView setImageWithURL:[NSURL URLWithString:object.firstImageURL]];
            
            _secondImageView.frame = CGRectMake(CGRectGetMaxX(_firstImageView.frame) + 14, CGRectGetMinY(_firstImageView.frame), CGRectGetWidth(_firstImageView.frame), CGRectGetHeight(_firstImageView.frame));
            
            [_secondImageView setImageWithURL:[NSURL URLWithString:object.secondImageURL]];
            
            _thirdImageView.frame = CGRectMake(CGRectGetMaxX(_secondImageView.frame) + 14, CGRectGetMinY(_secondImageView.frame), CGRectGetWidth(_firstImageView.frame), CGRectGetHeight(_firstImageView.frame));
            
            [_thirdImageView setImageWithURL:[NSURL URLWithString:object.thirdImageURL]];
            
        }
    }
}

- (void)fillCellWithObject:(id)object
{
    self.object = object;    
}

+ (CGFloat)rowHeightForObject:(id)object
{
    if ([object isMemberOfClass:[XTNewsDefaultObject class]] || [object isMemberOfClass:[XTNewsDefaultTagObject class]] || [object isMemberOfClass:[XTNewsDefaultSpecialObject class]]) {
        
        return 71;
        
    }else if ([object isMemberOfClass:[XTNewsAtlasObject class]]) {
        
        return 63 + 8 + 20 + 10 + 10;
    }
    return 71;
}

- (NSString *)replyCount:(NSString *)replyCount
{
    int count = [replyCount intValue];
    if (count < 10000) {
        return replyCount;
    }else{
        return [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
