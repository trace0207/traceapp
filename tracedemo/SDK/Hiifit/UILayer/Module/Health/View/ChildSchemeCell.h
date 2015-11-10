//
//  ChildSchemeCell.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFLevelView.h"
#import "SubSchemeHomeAck.h"
#import "SchemeActionsAck.h"
#import "SchemePunchAck.h"

@interface ChildSchemeCell : UITableViewCell
//Cell0
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *diseaseLable;
@property (weak, nonatomic) IBOutlet UILabel *organLabel;
@property (weak, nonatomic) IBOutlet HFLevelView *levelView;
@property (weak, nonatomic) IBOutlet UIView   *bgView;
@property (weak, nonatomic) IBOutlet UIButton *addSchemeBtn;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;

//Cell1
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *lineImage;

//Cell2
@property (weak, nonatomic) IBOutlet UILabel *punchLabel;

//Cell3
@property (weak, nonatomic) IBOutlet BasePortraitView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;

//添加按钮
- (void)addSchemeSelector:(SEL)selector withTarget:(id)target andObject:(id)object;
//点击头像
- (void)userCenterSelector:(SEL)selector withTarget:(id)target;
//顶部数据
- (void)addTopData:(SubSchemeHomeData *)data;
//动作组
- (void)addActions:(NSArray *)actions withSelector:(SEL)selector andTarget:(id)target;
//头像重叠数组
- (void)setPunchCards:(NSArray *)men completeCount:(NSInteger)completeCount;
//最近打卡人列表
- (void)setPunchMen:(SchemePunchList *)data;
@end
