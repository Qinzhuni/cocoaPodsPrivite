//
//  NSString+Types.m
//  app
//
//  Created by Haren on 14-7-1.
//  Copyright (c) 2015年 辣妈帮. All rights reserved.
//

#import "NSString+Types.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSString_Extended)

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([[string stringByReplacingOccurrencesOfString:@"\n" withString:@""] length]==0) {
        return YES;
    }
    
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string length]==0) {
        return YES;
    }
    
    return NO;
}

- (NSString *)withPrefix:(NSString*)str {
    return [NSString stringWithFormat:@"%@%@", str, self];
}

- (NSString *)withTail:(NSString*)str {
    return [NSString stringWithFormat:@"%@%@", self, str];
}

- (NSString *)rmb {
    if ([self isEqualToString:@""]) {
        return @"￥0";
    }
    return [NSString stringWithFormat:@"￥%@", self];
}

- (NSString *)dollor {
    return [NSString stringWithFormat:@"$%@", self];
}

-(NSString *)isEmpty:(NSString*)string {
    if (![string isKindOfClass:[NSString class]] || string.length == 0) {
        return @"";
    }else {
        return string;
    }
}

+ (BOOL)isEmptyString:(NSString *)string  {
    
    if (!string || [string isKindOfClass:[NSNull class]] || ![string isKindOfClass:[NSString class]]) {
        return YES;
    } else if ([string isEqualToString:@""]){
        return YES;
    }
    
    return NO;
}

+ (NSString *)stringValue:(NSString *)str {
    if (!str) {
        return @"";
    }
    
    if ([str isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)str;
        return [number stringValue];
    }
    
    if (![str isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    return str;
}

+ (NSString *)md5:(NSString *)str {
//    NSLog(@"description: %@",[str description]);
    
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString*)fileMD5:(NSData *)fileData {
    if (!fileData) {
        return @"ERROR GETTING FILE MD5";
    }// file didnt exist
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    CC_MD5_Update(&md5, [fileData bytes], (int)[fileData length]);
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSString *md5Str = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        digest[0], digest[1],
                        digest[2], digest[3],
                        digest[4], digest[5],
                        digest[6], digest[7],
                        digest[8], digest[9],
                        digest[10], digest[11],
                        digest[12], digest[13],
                        digest[14], digest[15]];
    return [md5Str lowercaseString];
}


+ (int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}

#pragma mark - ***************  coreText ******************************
/**
 *  字间距 设置
 *
 *  string:     正常字符串
 *  kern:       设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
 *  textColor:  文本颜色
 *  font:       字体大小
 *
 *  return: NSAttributedString
 */
+ (NSAttributedString *)coreTextWithStrin:(NSString *) string
                                     kern:(NSNumber *) kern
                                textColor:(UIColor *)color
                                      Font:(UIFont *) font {
    
    NSDictionary *textInfo = @{ NSKernAttributeName: kern,
                                 NSFontAttributeName: font,
                                NSForegroundColorAttributeName: color
                                };
    return [[NSAttributedString alloc] initWithString:string attributes:textInfo];
}

/**
 *  段间距 设置
 *
 *  string:             正常字符串
 *  paragraphSpacing:   段距，取值 float, 负值无效，取0值
 *  textColor:          文本颜色
 *  font:               字体大小
 *
 *  return: NSAttributedString
 */
+ (NSAttributedString *)coreTextWithString:(NSString *)string
                          ParagraphSpacing:(CGFloat)paragraphSpacing
                                 textColor:(UIColor *)color
                                      Font:(UIFont *)font {
   
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.paragraphSpacing = paragraphSpacing;
    
    NSDictionary *textInfo = @{ NSParagraphStyleAttributeName: paraStyle,
                                  NSFontAttributeName: font,
                                NSForegroundColorAttributeName: color
                                  };
    return [[NSAttributedString alloc] initWithString:string attributes:textInfo];
}

/**
 *  段间距 && 行间距    设置
 *
 *  string:             正常字符串
 *  paragraphSpacing:   段距，取值 float, 负值无效，取0值
 *  textColor:          文本颜色
 *  font:               字体大小
 *
 *  return: NSAttributedString
 */
+ (NSAttributedString *)coreTextWithString:(NSString *)string
                          ParagraphSpacing:(CGFloat)paragraphSpacing
                               lineSpacing:(CGFloat)lineSpacing
                                 textColor:(UIColor *)color
                                      Font:(UIFont *)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.paragraphSpacing = paragraphSpacing;
    paraStyle.lineSpacing = lineSpacing;
    
    NSDictionary *textInfo = @{ NSParagraphStyleAttributeName: paraStyle,
                                NSFontAttributeName: font,
                                NSForegroundColorAttributeName: color
                                };
    return [[NSAttributedString alloc] initWithString:string attributes:textInfo];
}



/**
 *  首行缩进
 *
 *  string:                 正常字符串
 *  firstLineHeadIndent:    首行缩进，取值 float
 *  textColor:              文本颜色
 *  font:                   字体大小
 *
 *  return: NSAttributedString
 **/
+ (NSAttributedString *)coreTextWithString:(NSString *)string
                       firstLineHeadIndent:(CGFloat)firstLineHeadIndent
                                 textColor:(UIColor *)color
                                  withFont:(UIFont *)font {
    // NSParagraphStyle
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.firstLineHeadIndent = firstLineHeadIndent;
    
    NSDictionary *textInfo = @{ NSParagraphStyleAttributeName: paraStyle,
                                  NSFontAttributeName: font,
                                NSForegroundColorAttributeName: color
                                  };
    return [[NSAttributedString alloc] initWithString:string attributes:textInfo];
}


+ (NSString *)ignoreBlankAndLine:(NSString *)string
{
    return  string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end



