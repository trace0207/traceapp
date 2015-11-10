//
//  HFHealthCell.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFCoverFlowView.h"
#import "HFInsightLargeImageView.h"
#import "BaseTableCell.h"
#import "MLEmojiLabel.h"
@class HFProgressView;
@class HFFoodCardView;
@class HFItem;
typedef NS_ENUM(NSInteger, cellEventType) {
    eat_Event = 0,         //进入好好吃饭详情
    eat_Prize_Event,       //吃好饭领奖
    sport_Prize_Event,     //运动完领奖
    sport_Event,           //运动一下详情
    walk_Prize_Event,      //走路完领奖
    walk_unable_Event,     //无法获取到走路日记
    context_Prize_Event,   //日记领奖
    context_Write_Event,   //写日记
    more_tips_Event,       //锦囊妙计详情
    more_news_Event,       //咨询的详情
    more_forum_Event,      //论坛的详情
};

typedef NS_ENUM(NSInteger, cellType) {
    DayCell_Type = 0,
    EatCell_Type,
    WalkCell_Type,
    ContextCell_Type,
    SportCell_Type,
    MoreCell_Type,
};

@protocol HFHealthCellDelegate <NSObject>

/**
 *  该函数为唯一向外反馈函数
 *
 *  @param type 反馈出去的事件类型
 */
- (void)healthCellReponseEvent:(cellEventType)type withObject:(id)object;


- (void)daysCoverSelect:(NSInteger)day;

@end

@interface HFHealthCell : BaseTableCell

@property (weak, nonatomic) id<HFHealthCellDelegate>delegate;

//sport
@property (weak, nonatomic) IBOutlet UIImageView *sport_HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *sport_Title;
@property (weak, nonatomic) IBOutlet UILabel *sport_Score;
@property (weak, nonatomic) IBOutlet UILabel *sport_Label;
@property (weak, nonatomic) IBOutlet UIButton *sport_Button;
@property (weak, nonatomic) IBOutlet UIButton *sport_PrizeButton;
//日记
@property (weak, nonatomic) IBOutlet HFInsightLargeImageView *context_Image;
@property (weak, nonatomic) IBOutlet MLEmojiLabel *context_Lable;
@property (weak, nonatomic) IBOutlet UIImageView *context_HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *context_Title;
@property (weak, nonatomic) IBOutlet UILabel *context_score;
@property (weak, nonatomic) IBOutlet UIButton *context_PrizeButton;
@property (weak, nonatomic) IBOutlet UIButton *context_WirteBtn;
//walk的模块
@property (weak, nonatomic) IBOutlet UIImageView *walk_TitleImage;
@property (weak, nonatomic) IBOutlet UILabel *walk_Title;
@property (weak, nonatomic) IBOutlet UILabel *walk_Score;
@property (weak, nonatomic) IBOutlet HFProgressView *walk_progressView;
@property (weak, nonatomic) IBOutlet UILabel *walk_currentStepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *walk_maxSetpLabel;
@property (weak, nonatomic) IBOutlet UIButton *walk_PrizeButton;
@property (weak, nonatomic) IBOutlet UIButton * walk_unableButton;
//day 的模块
@property (weak, nonatomic) IBOutlet HFCoverFlowView *day_coverView;
@property (weak, nonatomic) IBOutlet UILabel *day_daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *day_Title;

//吃饭的模块
@property (weak, nonatomic) IBOutlet HFFoodCardView *eat_breakFastView;
@property (weak, nonatomic) IBOutlet HFFoodCardView *eat_lunchView;
@property (weak, nonatomic) IBOutlet HFFoodCardView *eat_nightView;
@property (weak, nonatomic) IBOutlet HFFoodCardView *eat_drinkView;
@property (weak, nonatomic) IBOutlet UIImageView *eat_TitleImage;
@property (weak, nonatomic) IBOutlet UILabel *eat_scroLabel;
@property (weak, nonatomic) IBOutlet UILabel *eat_Title;
@property (weak, nonatomic) IBOutlet UIButton *eat_PrizeButton;

//more 的模块
@property (weak, nonatomic) IBOutlet HFItem * more_newsItem;
@property (weak, nonatomic) IBOutlet HFItem * more_tipsItem;
@property (weak, nonatomic) IBOutlet HFItem * more_forumItem;
/**
 *  点击运动一下的按钮出发的动作
 *
 */
- (IBAction)sportAction:(UIButton *)sender;

- (IBAction)writeContextAction:(id)sender;

- (IBAction)sportPrizeAction:(id)sender;

- (IBAction)eatPrizeAction:(id)sender;

- (IBAction)walkPrizeAction:(id)sender;

- (IBAction)contextPrizeAction:(id)sender;

- (IBAction)unableWalkStep:(id)sender;

/**
 *  设置日期Cell的数据
 */

- (void)setContentData:(id)data
              withType:(cellType)type
          isHistoryDay:(BOOL)bHistory
            withObject:(id)object;


- (void)resetPrizeFinish:(cellType)type;

- (void)resetWalkSteps:(NSInteger)steps withTargetSteps:(NSInteger)targetSteps;

+ (CGFloat)heightForHealthCell:(id)data atIndexPath:(NSIndexPath *)indexPath;

@end
