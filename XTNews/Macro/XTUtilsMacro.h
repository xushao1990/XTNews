//
//  XTUtilsMacro.h
//  MTLLDefine
//
//  Created by tage on 14-4-8.
//  Copyright (c) 2014年 XuShao. All rights reserved.
//

#ifndef MTLLDefine_XTUtilsMacro_h
#define MTLLDefine_XTUtilsMacro_h

#define NSStringFromInt(intValue) [NSString stringWithFormat:@"%d",intValue]

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#endif
