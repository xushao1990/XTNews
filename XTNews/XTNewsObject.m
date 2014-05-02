//
//  XTNewsObject.m
//  XTNews
//
//  Created by tage on 14-4-30.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTNewsObject.h"

@implementation XTNewsObject

+ (instancetype)shareNewsObjectWithDictionary:(NSDictionary *)dic
{
    NSString *title = [dic objectForKey:@"title"];
    
    NSString *imageSRC = [dic objectForKey:@"imgsrc"];
    
    NSArray *keys = [dic allKeys];
    
    if ([keys indexOfObject:@"url_3w"] == NSNotFound) {
        
        if ([keys indexOfObject:@"template"] == NSNotFound) {
            
            if ([keys indexOfObject:@"imgextra"] == NSNotFound) {
                
                XTNewsDefaultAtlasObject *object = [[XTNewsDefaultAtlasObject alloc] init];
                
                object.title = title;
                
                object.imageSRC = imageSRC;
                
                object.digest = [dic objectForKey:@"digest"];
                
                object.replyCount = [dic objectForKey:@"replyCount"];
                
                return object;
                
            }else{
                
                XTNewsAtlasObject *object = [[XTNewsAtlasObject alloc] init];
                
                object.title = title;
                
                object.firstImageURL = imageSRC;
                
                object.replyCount = [dic objectForKey:@"replyCount"];
                
                NSArray *subImage = [dic objectForKey:@"imgextra"];
                
                [subImage enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    if (idx == 0) {
                        
                        object.secondImageURL = obj[@"imgsrc"];
                        
                    }else if (idx == 1) {
                        
                        object.thirdImageURL = obj[@"imgsrc"];
                        
                    }else{
                        
                        *stop = YES;
                    }
                }];
                
                return object;
            }
            
        }else{
            
            XTNewsHeaderObject *object = [[XTNewsHeaderObject alloc] init];
            
            object.title = title;
            
            object.imageSRC = imageSRC;
            
            return object;
        }
        
    }else{
        
        if ([keys indexOfObject:@"imgextra"] != NSNotFound) {
         
            XTNewsAtlasObject *object = [[XTNewsAtlasObject alloc] init];
            
            object.title = title;
            
            object.replyCount = [dic objectForKey:@"replyCount"];
            
            object.firstImageURL = imageSRC;
            
            NSArray *subImage = [dic objectForKey:@"imgextra"];
            
            [subImage enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                if (idx == 0) {
                    
                    object.secondImageURL = obj[@"imgsrc"];
                    
                }else if (idx == 1) {
                    
                    object.thirdImageURL = obj[@"imgsrc"];
                    
                }else{
                    
                    *stop = YES;
                }
            }];
            
            return object;
            
        }else if ([keys indexOfObject:@"specialID"] != NSNotFound) {
            
            XTNewsDefaultSpecialObject *object = [[XTNewsDefaultSpecialObject alloc] init];
            
            object.title = title;
            
            object.imageSRC = imageSRC;
            
            object.digest = [dic objectForKey:@"digest"];
            
            return object;
            
        }else if ([keys indexOfObject:@"TAG"] != NSNotFound) {
            
            XTNewsDefaultTagObject *object = [[XTNewsDefaultTagObject alloc] init];
            
            object.title = title;
            
            object.imageSRC = imageSRC;
            
            object.tag = [dic objectForKey:@"TAG"];
            
            object.replyCount = [dic objectForKey:@"replyCount"];
            
            object.digest = [dic objectForKey:@"digest"];

            return object;
            
        }else{
            
            XTNewsDefaultObject *object = [[XTNewsDefaultObject alloc] init];
            
            object.title = title;
            
            object.imageSRC = imageSRC;
            
            object.replyCount = [dic objectForKey:@"replyCount"];
            
            object.digest = [dic objectForKey:@"digest"];

            return object;
        }
 
    }
    return nil;
}

@end


@implementation XTNewsHeaderObject

@end

@implementation XTNewsAtlasObject

@end

@implementation XTNewsDefaultObject

@end

@implementation XTNewsDefaultAtlasObject

@end

@implementation XTNewsDefaultSpecialObject

@end

@implementation XTNewsDefaultTagObject

@end




