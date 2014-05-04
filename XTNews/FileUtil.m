//
//  FileUtil.m
//  KG4-0
//
//  Created by zhuyw on 11-5-21.
//  Copyright 2011年 TargTime. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+ (BOOL)createFolder:(NSString *)dint {
	@try {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		if ([fileManager fileExistsAtPath:dint] != YES) {
			[fileManager createDirectoryAtPath:dint withIntermediateDirectories:YES attributes:nil error:nil];
		}
		
		return TRUE;
	}
	@catch (NSException *exception) {
		return FALSE;
	}
}

+ (void)remove:(NSString *)path {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:path] == YES) {
		[fileManager removeItemAtPath:path error:nil];
	}
}

+ (void)copyFile:(NSString *)src dint:(NSString *)dint {
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:src] == YES) {
        
        NSData *temData = [NSData dataWithContentsOfFile:src];
        
        [temData writeToFile:dint atomically:YES];
        
//		[fileManager copyItemAtPath:src toPath:dint error:nil];
	}
}

+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (int)fileLength: (NSString *) path
{
    int length = 0;
    
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    if ([fileMgr fileExistsAtPath:path isDirectory:&isDir])
    {
        if (isDir == NO)
        {
            NSDictionary * attrs = [fileMgr attributesOfItemAtPath:path error:nil];
            NSNumber * fileSize = [attrs objectForKey:NSFileSize];
            
            if (fileSize != nil)
            {
                length = [fileSize intValue];
            }
        }
    }
    
    return length;
}

+ (BOOL)fileExit:(NSString *)filepath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        return YES;
    }else{
        return NO;
    }
}

@end
