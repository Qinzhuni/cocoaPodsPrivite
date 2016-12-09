//
//  NSString+Types.h
//  app
//
//  Created by Haren on 14-7-1.
//  Copyright (c) 2015年 辣妈帮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (NSString_Extended)

- (NSString *)urlencode;

- (NSString *)withPrefix:(NSString*)str;
- (NSString *)withTail:(NSString*)str;
- (NSString *)rmb;
- (NSString *)dollor;
- (NSString *)isEmpty:(NSString*)string;
//- (NSString *)URLEncodedString;
+ (BOOL) isBlankString:(NSString *)string;

+ (NSString *)stringValue:(NSString *)str;
+ (NSString *)md5:(NSString *)str;
+ (NSString*)fileMD5:(NSData *)fileData;
+ (BOOL)isEmptyString:(NSString *)string;
+ (int)convertToInt:(NSString*)strtemp;


//去除首尾空格和换行
+ (NSString *)ignoreBlankAndLine:(NSString *)string;







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
                                     Font:(UIFont *) font;
/**
 *  行间距 设置
 *
 *  string:         正常字符串
 *  lineSpacing:    行距，取值为 float，可正可负，正值增加行距，负值减小行距
 *  textColor:      文本颜色
 *  font:           字体大小
 *
 *  return: NSMutableAttributedString
 */
//+ (NSMutableAttributedString *)coreTextWithString:(NSString *)string
//                               lineSpacing:(CGFloat)lineSpacing
//                                 textColor:(UIColor *)color
//                                  fontSize:(CGFloat)fontSize;
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
                                      Font:(UIFont *)font;

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
                                      Font:(UIFont *)font;


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
                                  withFont:(UIFont *)font;

@end
