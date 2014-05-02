//
//  XTReleaseMacro.h
//  MTLLDefine
//
//  Created by tage on 14-4-8.
//  Copyright (c) 2014年 XuShao. All rights reserved.
//

#ifndef MTLLDefine_XTReleaseMacro_h
#define MTLLDefine_XTReleaseMacro_h

#define SAFE_VIEW_RELEASE(obj) if(obj && obj.superview){[obj removeFromSuperview];obj=nil;}

#endif
