//
//  XTColorMacro.h
//  MTLLDefine
//
//  Created by tage on 14-4-8.
//  Copyright (c) 2014年 XuShao. All rights reserved.
//

#ifndef MTLLDefine_XTColorMacro_h
#define MTLLDefine_XTColorMacro_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#endif
