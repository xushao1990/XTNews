//
//  DefineLayout Header.h
//  Define
//
//  Created by tage on 14-4-8.
//  Copyright (c) 2014年 XuShao. All rights reserved.
//

#ifndef MTLLDefine_XTLayoutMacro_h
#define MTLLDefine_XTLayoutMacro_h

#define kIS_IPHONE5             (([[UIScreen mainScreen] bounds].size.height - 568) ? NO : YES)

#define kIPHONE5DIS(X) ([[NSNumber numberWithBool:kIS_IPHONE5] intValue] * X)

#define kIS_IOS7                (kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_6_1)

#define kIOS7DIS(X) ([[NSNumber numberWithBool:kIS_IOS7] intValue] * X)

#define kIS_IOS6                (kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_5_1)

#endif
