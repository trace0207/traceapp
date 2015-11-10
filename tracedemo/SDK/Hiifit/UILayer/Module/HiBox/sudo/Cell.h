//
//  Cell.h
//  ShuDu
//
//  Created by hermit on 15/3/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellWidth          (32*kScreenScale)
#define kHighlitedWidth     (38*kScreenScale)
#define kCellSpace          ((kScreenWidth - 9*(kCellWidth))/4)
#define kBottomHeight       (94.0f/78.0f)*kCellWidth
#define kGridNum            9
#define kValueKey           @"value"
#define kBlankKey           @"blank"

@interface Cell : UIView

@property (nonatomic, assign) NSInteger     value;
@property (nonatomic, strong) UILabel       *discreetLabel;
@property (nonatomic, strong) UIButton      *cellBtn;
@property (nonatomic, strong) UIImageView   *higlitedImageView;

@property (nonatomic, getter = isBlank) BOOL  blank;//是否显示数值

- (instancetype)initWithX:(NSInteger)x andY:(NSInteger)y;

- (void)setValue:(NSInteger)value isBlank:(BOOL)blank;

- (void)setValueMarkLabel:(NSString *)value;

- (void)showTheNumber;

@end
