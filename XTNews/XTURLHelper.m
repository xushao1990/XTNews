//
//  XTURLHelper.m
//  XTNews
//
//  Created by tage on 14-5-4.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "XTURLHelper.h"

@implementation XTURLHelper

+ (NSString *)URLencode4UTF8:(NSString *)originalString
{
    //	return [self URLencode:originalString enCoding:kCFStringEncodingUTF8];
	//!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
	
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
	
    NSInteger len = [escapeChars count];
	
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:enc]
                             mutableCopy];
	
    int i;
    for (i = 0; i < len; i++) {
		
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
	
    NSString *outStr = [NSString stringWithString: temp];
	
    return outStr;
}

@end
