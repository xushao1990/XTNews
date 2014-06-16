//
//  XTAddButton.m
//  XTNews
//
//  Created by XT on 14-6-16.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTAddButton.h"

@implementation XTAddButton
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat length[] = {4,2};
    CGContextSetLineDash(context, 0, length, 2);  //画虚线
    UIColor* color = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0 alpha: 1];
    CGRect rectangleRect = self.bounds;
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rectangleRect];
    [color setStroke];
    rectanglePath.lineWidth = 0.5;
    [rectanglePath stroke];
    [color setFill];
    [@"添加分类" drawInRect: CGRectInset(rectangleRect, 0, 8) withFont:[UIFont fontWithName:@"Helvetica" size: 12.5] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
}


@end
