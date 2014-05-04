//
//  NSString+Extension.m
//  CocoapodTest
//
//  Created by tage on 14-4-9.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>



@implementation NSString (Extension)

- (NSString*) MD5 {
	unsigned int outputLength = CC_MD5_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_MD5(self.UTF8String, [self UTF8Length], output);
	return [self toHexString:output length:outputLength];;
}

- (NSString*) SHA1 {
	unsigned int outputLength = CC_SHA1_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA1(self.UTF8String, [self UTF8Length], output);
	return [self toHexString:output length:outputLength];;
}

- (NSString*) SHA256 {
	unsigned int outputLength = CC_SHA256_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA256(self.UTF8String, [self UTF8Length], output);
	return [self toHexString:output length:outputLength];;
}

- (unsigned int) UTF8Length {
	return (unsigned int) [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*) toHexString:(unsigned char*) data length: (unsigned int) length {
	NSMutableString* hash = [NSMutableString stringWithCapacity:length * 2];
	for (unsigned int i = 0; i < length; i++) {
		[hash appendFormat:@"%02x", data[i]];
		data[i] = 0;
	}
	return hash;
}

- (NSString *)cachedFileName
{
    if (self) {
        const char *str = [self UTF8String];
        if (str == NULL)
        {
            str = "";
        }
        unsigned char r[CC_MD5_DIGEST_LENGTH];
        CC_MD5(str, (CC_LONG)strlen(str), r);
        NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                              r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
        
        return filename;
    }else {
        return nil;
    }
}

- (BOOL)containsEmoji {
    if (self) {
        __block BOOL returnValue = NO;
        [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
         ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
             
             const unichar hs = [substring characterAtIndex:0];
             // surrogate pair
             if (0xd800 <= hs && hs <= 0xdbff) {
                 if (substring.length > 1) {
                     const unichar ls = [substring characterAtIndex:1];
                     const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                     if (0x1d000 <= uc && uc <= 0x1f77f) {
                         returnValue = YES;
                     }
                 }
             } else if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 if (ls == 0x20e3) {
                     returnValue = YES;
                 }
                 
             } else {
                 // non surrogate
                 if (0x2100 <= hs && hs <= 0x27ff) {
                     returnValue = YES;
                 } else if (0x2B05 <= hs && hs <= 0x2b07) {
                     returnValue = YES;
                 } else if (0x2934 <= hs && hs <= 0x2935) {
                     returnValue = YES;
                 } else if (0x3297 <= hs && hs <= 0x3299) {
                     returnValue = YES;
                 } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                     returnValue = YES;
                 }
             }
         }];
        
        return returnValue;
    }else{
        return NO;
    }
}

- (BOOL)containsSpecialChar
{
    if (self) {
        char* utf8Replace = "\xe2\x80\x86\0";
        
        NSData *data = [NSData dataWithBytes:utf8Replace length:strlen(utf8Replace)];
        
        NSString *utf8_str_format = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if ([self rangeOfString:utf8_str_format].location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)deleteSpecialChar
{
    if (self) {
        char* utf8Replace = "\xe2\x80\x86\0";
        
        NSData *data = [NSData dataWithBytes:utf8Replace length:strlen(utf8Replace)];
        
        NSString *utf8_str_format = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSMutableString *mutableAblumName = [NSMutableString stringWithString:self];
        
        return [mutableAblumName stringByReplacingOccurrencesOfString:utf8_str_format withString:@""];
    }else{
        return nil;
    }
}

@end
