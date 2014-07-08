//
//  XTAdview.h
//  XTNews
//
//  Created by fengyulong on 14-7-7.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  策略
 *  当广告数量多于1个时会将广告的models重复3次添加到数据源，即分为3块。比如，ABCD|ABCD|ABCD
 *  一直显示最中间的ABCD
 *  当从中间的A滑动到左侧的D后，手动将iCarousel的当前展示的index设置为中间的D，当然是以无动画的形式
 *  同理，当从中间的D滑动到右侧的A后，手动将iCarousel的当前展示的index设置为中间的A，同样是以无动画的形式
 *  这样实现了循环滑动
 */

@interface XTAdview : UIView
- (id)initWithFrame:(CGRect)frame ads:(NSArray *)ads;
@end
