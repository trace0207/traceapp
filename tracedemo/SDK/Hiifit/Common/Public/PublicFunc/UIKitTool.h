//
//  UIKitTool.h
//  GuanHealth
//
//  Created by hermit on 15/2/28.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "PostDetailData.h"
#import "PostCell.h"
#import "HFMessageTypeInfoRes.h"
#import "HFCaculateHeightModel.h"
typedef void (^heightBlock) (CGFloat height, PostCellExpandState state);

@interface UIKitTool : NSObject
+ (AppDelegate*)getAppdelegate;
// set the property of Label
+ (void)setLabelPropertyWithLab:(UILabel *)aLab fontSize:(CGFloat)size textColor:(NSString *)textColor;
// fixed the origin
+ (void)setFixedView:(UIView *)fixedView withNewPosition:(CGPoint)point;
// fixed the Size
+ (void)setFixedView:(UIView *)fixedView withNewSize:(CGSize)size;
// check String is Empty
+(BOOL)isEmpty:(NSString *)string;

+ (void)callPhone:(NSString*)phone;

+ (void)sendMessage:(NSString*)phone;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (NSString*)getLargeImage:(NSString*)imageUrl;

+ (NSString*)getSmallImage:(NSString*)imageUrl;

+ (NSString*)getRawImage:(NSString*)imageUrl;

+ (NSString*)getTimeStrFromUTC:(int)seconds;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (NSString *)transfromFromWeeksStr:(NSString *)weeks;

+ (BOOL)checkSensitiveWords:(NSString *)text;

//计算HFMessageCell高度
+ (CGFloat)caculateHeightForMessage:(HFMessageTypeInfoData *)messageinfo
                    withMessageType:(MessageType)type;

//计算postCell高度
+ (HFCaculateHeightModel *)heightForEmojiText:(PostDetailData*)post isMainView:(BOOL)mainView;

//计算富文本高度
+ (CGFloat)heightForCell:(NSString *)emojiText
                withFont:(CGFloat)fontSize
               withWidth:(CGFloat)width;

//计算纯文本高度
+ (CGFloat)caculateHeight:(NSString *)text sizeOfWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes;

@end
