//
//  MCTopAligningLabel.m
//  MCTopAligningLabel
//
//  Created by Baglan on 11/29/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "MCTopAligningLabel.h"

@implementation MCTopAligningLabel

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    CGAffineTransform transform = self.transform;
    self.transform = CGAffineTransformIdentity;
    CGRect frame = self.frame;
    frame.size.height = size.height;
    self.frame = frame;
    self.transform = transform;
    
    [super layoutSubviews];
}

@end
