//
//  XTCornerButton.m
//  XTNews
//
//  Created by XT on 14-6-16.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTCornerButton.h"

typedef NS_ENUM(NSUInteger, XTCornerButtonState) {
    XTCornerButtonStateNormal,
    XTCornerButtonStateHighlighted,
};

@interface XTCornerButton ()
@property (nonatomic) XTCornerButtonState cornerButtonState;
@end

@implementation XTCornerButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cornerButtonState = XTCornerButtonStateNormal;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetWidth(self.bounds) / 2 - 8, CGRectGetHeight(self.bounds) / 2 - 3);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2 + 5);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.bounds) / 2 + 8, CGRectGetHeight(self.bounds) / 2 - 3);
    CGContextStrokePath(context);
}

- (BOOL)cornerButtonSelected
{
    if (self.cornerButtonState == XTCornerButtonStateNormal) {
        self.cornerButtonState = XTCornerButtonStateHighlighted;
        [UIView animateWithDuration:kCategoryShowAnimationTime animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        return YES;
    }else{
        self.cornerButtonState = XTCornerButtonStateNormal;
        [UIView animateWithDuration:kCategoryShowAnimationTime animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
        return NO;
    }
}


@end
