//
//  HFAdvanceSchemeCell.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"
#import "MainPageAdvanceSchemeAck.h"
typedef NS_ENUM(NSInteger, AdvanceSchemeType) {
    AdvanceScheme_None = 0,
    AdvanceScheme_One,
    AdvanceScheme_Two,
    AdvanceScheme_Three,
    AdvanceScheme_Begin,
};

@protocol HFAdvanceSchemeCellDelegate <NSObject>

@optional
- (void)detailSchemeClick:(NSInteger)schemeID;

- (void)beginUseAction:(NSInteger)schemeID;

- (void)mainSchemeClick:(NSInteger)subSchemeId schemeName:(NSString *)schemeName;

@end


@interface HFAdvanceSchemeCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UILabel *mSchemeOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *mShemeOneTime;
@property (weak, nonatomic) id<HFAdvanceSchemeCellDelegate>delegate;


@property (weak, nonatomic) IBOutlet  UIImageView * none_HeadImageView;
@property (weak, nonatomic) IBOutlet  UILabel   * none_TitleLabel;
@property (weak, nonatomic) IBOutlet  UILabel   * none_introduceLabel;

@property (weak, nonatomic) IBOutlet  UIImageView * one_HeadImageView;
@property (weak, nonatomic) IBOutlet  UILabel   * one_TitleLabel;
@property (weak, nonatomic) IBOutlet  UILabel   * one_introduceLabel;

@property (weak, nonatomic) IBOutlet  UIImageView * more_HeadImageView;
@property (weak, nonatomic) IBOutlet  UILabel   * more_TitleLabel;
@property (weak, nonatomic) IBOutlet  UILabel   * more_introduceLabel;

@property (weak, nonatomic) IBOutlet  UIImageView * begin_HeadImageView;
@property (weak, nonatomic) IBOutlet  UILabel   * begin_TitleLabel;
@property (weak, nonatomic) IBOutlet  UILabel   * begin_introduceLabel;
@property (weak, nonatomic) IBOutlet  UIImageView * begin_newImageView;
@property (weak, nonatomic) IBOutlet  UILabel    * begin_SubscribeLabel;
@property (weak, nonatomic) IBOutlet  UIImageView * begin_addBtn;
@property (weak, nonatomic) IBOutlet  UIImageView * bgImageView;
- (IBAction)singleSchemeAction:(UIButton *)sender;

- (IBAction)useAction:(UIButton *)sender;

- (void)setContentData:(MainPageAdvanceSchemeData *)data;

+ (CGFloat)cellHeightForData:(MainPageAdvanceSchemeData *)data atIndex:(NSInteger)index;

+ (AdvanceSchemeType)cellTypeForData:(MainPageAdvanceSchemeData *)data;


@end
