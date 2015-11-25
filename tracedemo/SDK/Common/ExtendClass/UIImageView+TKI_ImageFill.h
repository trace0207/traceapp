//
//  UIImageView+TKI_ImageFill.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/24.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (TKI_ImageFill)

/**
 *  <#Description#>
 *
 *  @param withDefult <#withDefult description#>
 *  @param image      <#image description#>
 */
-(void)TK_fillWithUrl:(NSURL *) url withDefult:(UIImage *)image;



-(void)TK_fillWithStrUrl:(NSString *)str withDefaultImageResouceName:(NSString *)imageName;

-(void)TK_fillDefaultHeadImage:(NSString *)url;

@end
