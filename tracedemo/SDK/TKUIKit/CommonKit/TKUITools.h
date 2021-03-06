//
//  TKUITools.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKUITools : NSObject



/**
 *  显示一个大图
 *
 *  @param picUrl    picurl
 *  @param imageView 绑定的UIImageVIew
 */
+(void)showImageInBigScreen:(NSString *)picUrl withImageView:(UIImageView *)imageView;



/**
 *  显示一组大图
 *
 *  @param picUrl    picurl
 *  @param imageView 绑定的UIImageVIew
 */
+(void)showImagesInBigScreen:(NSArray *)picUrls withImageViews:(NSArray *)imageViews currentIndex:(NSInteger)index;


//计算纯文本宽度
+ (CGFloat)getTextWidth:(NSString *)text withFontSize:(UIFont *)font;



//计算纯文本高度
+ (CGFloat)getTextHeight:(NSString *)text withFontSize:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 删除view的子view
 **/
+(void)removeAllChildViews:(UIView *)view;

/**
 设置圆角border
 **/

+(void)setRoudBorderForView:(UIView *)view
                borderColor:(UIColor *)color
                     radius:(CGFloat)radius
                borderWidth:(CGFloat)width;

/**
 返回默认的  list 加载数据为空的视图
 **/
+(UIView *)getListViewEmptyTip;

/**
 返回解析过后的图片地址
 **/
+ (NSString*)getRawImage:(NSString*)imageUrl;
@end
