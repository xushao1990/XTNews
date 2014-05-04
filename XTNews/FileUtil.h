//
//  FileUtil.h
//  KG4-0
//
//  Created by zhuyw on 11-5-21.
//  Copyright 2011年 TargTime. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileUtil : NSObject

+ (BOOL)createFolder:(NSString *)dint;

+ (void)remove:(NSString *)path;

+ (void)copyFile:(NSString *)src dint:(NSString *)dint;

+ (int)fileLength: (NSString *) path;

+ (BOOL)fileExit:(NSString *)filepath;

+ (float)folderSizeAtPath:(NSString *)folderPath;

@end
