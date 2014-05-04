//
//  CircleView.m
//  Demo8
//
//  Created by Leon on 11/15/13.
//  Copyright (c) 2013 Leon. All rights reserved.
//

#import "XTRefreshView.h"


@interface CircleView : UIView

@property (nonatomic) float progress;

@end

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.776471 green:0.196078 blue:0.207843 alpha:1.0].CGColor);
    CGFloat startAngle = -M_PI/3;
    CGFloat step = 11*M_PI/6 * self.progress;
    CGContextAddArc(context, self.bounds.size.width / 2 , self.bounds.size.height / 2, self.bounds.size.height / 2 - 3, startAngle, startAngle+step, 0);
    CGContextStrokePath(context);
}


@end

@interface XTRefreshView ()

@property (nonatomic , strong) CircleView *circleView;

@end

@implementation XTRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _circleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [self addSubview:_circleView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (_progress >= 0) {
        
        [_circleView setProgress:_progress];
    }
    
    if (self.progress == 1) {
        
        [self drawText:@"松开立即刷新"];
        
    }else if (self.progress > 1){
        
        [self drawText:@"刷新完成"];
        
    }else if (self.progress > 0){
        
        [self drawText:@"下拉刷新"];

    }else if (self.progress < 0){
        
        [self drawText:@"正在刷新..."];
        
    }
}

- (void)drawText:(NSString *)text
{
    [text drawInRect:CGRectMake(self.bounds.size.height + 10, 5, 100, self.bounds.size.height) withFont:[UIFont systemFontOfSize:13] lineBreakMode:NSLineBreakByWordWrapping];
}

- (void)startAnimation
{
    [self setProgress:-1];
    
    CABasicAnimation* rotate =  [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    rotate.removedOnCompletion = FALSE;
    rotate.fillMode = kCAFillModeForwards;
    
    //Do a series of 5 quarter turns for a total of a 1.25 turns
    //(2PI is a full turn, so pi/2 is a quarter turn)
    [rotate setToValue: [NSNumber numberWithFloat: M_PI / 2]];
    rotate.repeatCount = 11;
    
    rotate.duration = 0.25;
    //            rotate.beginTime = start;
    rotate.cumulative = TRUE;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [_circleView.layer addAnimation:rotate forKey:@"rotateAnimation"];
}

- (void)endAnimation
{
    [_circleView.layer removeAllAnimations];
    [self setProgress:2];
}

@end
