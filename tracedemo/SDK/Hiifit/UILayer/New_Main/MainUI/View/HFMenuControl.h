//
//  Menu.h
//  menu
//
//  Created by zhuxiaoxia on 15/8/31.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TK_ShareCategory.h"

typedef NS_ENUM(NSInteger,HFMenuType) {
    HFMenuTypeRight =   0,
    HFMenuTypeLeft  =   1,
    HFMenuTypeCenter=   2,
};

@protocol HFMenuDelegate <NSObject>

@optional
- (CGFloat)heightForCell;

@required
- (void)MenuDidSelectIndex:(NSInteger)index;

@end

@interface HFMenuControl : UIView

@property (nonatomic, weak) id<HFMenuDelegate>delegate;


- (instancetype)initWithCategorys:(NSMutableArray *)categorys;

- (instancetype)initWithCategorys:(NSMutableArray *)categorys fromLeft:(Boolean)fromLeft;

- (void)showMenu;

@end
