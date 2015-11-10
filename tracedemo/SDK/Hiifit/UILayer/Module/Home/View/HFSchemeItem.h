//
//  HFSchemeItem.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/16.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFSchemeItemDelegate <NSObject>

- (void)itemClick:(NSInteger)subSchemeId subSchemeName:(NSString *)schemeName;

@end

@interface HFSchemeItem : UIView

@property(nonatomic,weak)id<HFSchemeItemDelegate>delegate;

- (void)setContentTitle:(NSString *)title
                bgImage:(NSString *)imageStr
               withName:(NSString *)name
             withtypeID:(NSInteger)schemeID;

@end
