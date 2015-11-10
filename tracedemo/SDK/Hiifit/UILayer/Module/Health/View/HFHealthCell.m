//
//  HFHealthCell.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHealthCell.h"
#import "HFFoodCardView.h"
#import "HFItem.h"
#import "HFProgressView.h"
#import "StepCounterManager.h"

#import "LoadSchemeDataAck.h"
#import "NSString+HFStrUtil.h"
#import "GetFoodsByDayAck.h"
#import "GetDiaryDataByDayAck.h"
#import "GetSportDataByDayAck.h"
#import "GetRunningDataAck.h"
#import "GetSchemeDayInfoAck.h"

#import "HFMixView.h"
#import "HFGuideView.h"

#import "MLEmojiLabel.h"
#import "UIImage+Scale.h"

#define kFirstLoginHealthModule @"firstLoginHealthModule"
@interface HFHealthCell()<HFFoodCardViewDelegate,HFCoverFlowViewDelegate>
{
    BOOL  bHistroyDay;
    
    BOOL  bHasSet;
}

@property(nonatomic,strong)HFMixView * mLockView;
@property(nonatomic,strong)HFMixView * mDirayView;
@end

@implementation HFHealthCell

- (void)awakeFromNib {
    
    [self.walk_progressView setProgressImage:IMG(@"progress_green")];
    [self.walk_progressView setTrackImage:IMG(@"dark_progress_small")];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    self.context_Lable.font                 = [UIFont systemFontOfSize:16.0f];
    self.context_Lable.numberOfLines        = 0;
    self.context_Lable.isNeedAtAndPoundSign = YES;
    self.context_Lable.lineBreakMode = NSLineBreakByTruncatingHead;
    self.context_Lable.customEmojiRegex     = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    self.context_Lable.customEmojiPlistName = @"expression.plist";
    
    [self.context_WirteBtn setBackgroundImage:[UIImage scaleWithImage:@"My_bigButton"] forState:UIControlStateNormal];
    [self.sport_Button setBackgroundImage:[UIImage scaleWithImage:@"My_bigButton"] forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  设置日期Cell的数据
 */



#pragma mark -
#pragma mark public

/**
 *  进行数据的初步处理
 *
 *  @param type 根据是什么Cell去处理
 */
- (void)setContentData:(id)data
              withType:(cellType)type
          isHistoryDay:(BOOL)bHistory
            withObject:(id)object
{
    bHistroyDay = bHistory;
    
    switch (type)
    {
        case DayCell_Type:
        {
            
            NSInteger offsetDay = [object integerValue];
            GetSchemeDayInfoAck * contentData = (GetSchemeDayInfoAck *)data;
            [self setContentForDayCell:contentData withOffsetDay:offsetDay];
            break;
        }
        case EatCell_Type:
        {
            
            GetFoodsByDayAck * contentData  = (GetFoodsByDayAck *)data;
            [self setContentForEatCell:contentData];
            break;
        }
        case WalkCell_Type:
        {
            GetRunningDataAck * contentData = (GetRunningDataAck *)data;
            [self setContentForWalkCell:contentData];
            break;
        }
        case ContextCell_Type:
        {
            GetDiaryDataByDayAck * contentData = (GetDiaryDataByDayAck *)data;
            [self setContentForContextCell:contentData];
            break;
        }
        case SportCell_Type:
        {
            NSInteger  stage = [object integerValue];
            
            BOOL bInScheme = stage == 1 ? NO : YES;
            
            GetSportDataByDayAck * contentData = (GetSportDataByDayAck *)data;
            [self setContentForSportCell:contentData inStrongScheme:bInScheme];
            break;
        }
        case MoreCell_Type:
        {
            GetSchemeDayInfoAck * contentData = (GetSchemeDayInfoAck *)data;
            [self setContentForMoreCell:contentData];
            break;
        }
        default:
            break;
    }
}

- (void)resetPrizeFinish:(cellType)type
{
    
    if (type == EatCell_Type)
    {
        self.eat_PrizeButton.enabled = NO;
        [self.eat_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
    }
    else if (type == WalkCell_Type)
    {
        self.walk_PrizeButton.enabled = NO;
        [self.walk_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
    }
    else if (type == ContextCell_Type)
    {
        self.context_PrizeButton.enabled = NO;
        [self.context_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
    }
    else
    {
        self.sport_PrizeButton.enabled = NO;
        [self.sport_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
    }
    
}

- (void)resetWalkSteps:(NSInteger)steps withTargetSteps:(NSInteger)targetSteps
{

    [self resetWalkSteps:steps];
    
    if (!targetSteps || targetSteps == 0)
    {
        [self.walk_progressView setProgress:0 animated:1.0];
        return;
    }
    CGFloat progress = (CGFloat)steps / (CGFloat)targetSteps;
    progress = progress > 1.0 ? 1.0 : progress;
    [self.walk_progressView setProgress:progress animated:1.0];
    
}

#pragma mark -
#pragma mark private

- (void)resetWalkSteps:(NSInteger)step
{
    if (step == -1 || step == 0)
    {
        //增加无法记步的功能按钮
        step = 0;
        self.walk_unableButton.hidden = NO;
        [self.walk_unableButton setImage:IMG(@"walkproblem") forState:UIControlStateNormal];
        
    }
    else
    {
        self.walk_unableButton.hidden = YES;
    }
    
    NSString * stepInfo = [NSString stringWithFormat:@"%ld步",(long)step];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:stepInfo];

    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor hexChangeFloat:@"999999" withAlpha:1.0]
                          range:NSMakeRange(stepInfo.length - 1, 1)];
    

    
    self.walk_currentStepsLabel.attributedText = attributedStr;
    
        [self.walk_currentStepsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(attributedStr.size.width);
        }];
}

- (void)setContentForDayCell:(GetSchemeDayInfoAck *)data withOffsetDay:(NSInteger)days
{
    if (!data)
    {
        return;
    }

    self.day_Title.text = [NSString stringWithFormat:@"%@:%@",data.data.stageName,data.data.stageTarget];
    self.day_daysLabel.text = [NSString stringWithFormat:@"%ld",(long)days];
   
    if (bHasSet)
    {
        return;
    }
    
    bHasSet = YES;
    
     self.day_coverView.delegate = self;

    [self.day_coverView setMaxCoverNum:data.data.days CurrentCoverNum:data.data.currDay visiableCover:data.data.currDay];
    
}

/**
 *  设置吃饭Cell的数据
 */

- (void)setContentForEatCell:(GetFoodsByDayAck *)data
{
    if (!data) {
        return;
    }
    
    //先设置标题的数据
    self.eat_Title.text = data.data.name;
    [self.eat_TitleImage sd_setImageWithURL:[NSURL URLWithString:data.data.icon] placeholderImage:nil];
    
    //然后设置
    if ([data.data.mealList count] != 4)
    {
        NSLog(@"数据出现问题");
        return;
    }
    else
    {
        //设置4个食物卡片的数据
        GetFoodsByMealData * breakfast = [data.data.mealList objectAtIndex:0];
        [self.eat_breakFastView setContentData:breakfast atHistory:bHistroyDay];
        self.eat_breakFastView.delegate = self;
        
        GetFoodsByMealData * lunch = [data.data.mealList objectAtIndex:1];
        [self.eat_lunchView setContentData:lunch atHistory:bHistroyDay];
        self.eat_lunchView.delegate = self;
        
        GetFoodsByMealData * dinner = [data.data.mealList objectAtIndex:2];
        [self.eat_nightView setContentData:dinner atHistory:bHistroyDay];
        self.eat_nightView.delegate = self;
        
        GetFoodsByMealData * drink = [data.data.mealList objectAtIndex:3];
        [self.eat_drinkView setContentData:drink atHistory:bHistroyDay];
        self.eat_drinkView.delegate = self;
        
        if (data.data.isOK)
        {
            self.eat_scroLabel.hidden = YES;
            self.eat_PrizeButton.hidden = NO;
            
            if (breakfast.flag && lunch.flag && dinner.flag && drink.flag)
            {
                self.eat_PrizeButton.enabled = NO;
                [self.eat_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
                
            }
            else
            {
                if (bHistroyDay)
                {
                    self.eat_PrizeButton.hidden = YES;
                    self.eat_scroLabel.hidden = NO;
                    self.eat_scroLabel.text = [NSString stringWithFormat:@"积分:%ld",(long)data.data.score];
                }
                else
                {
                    self.eat_PrizeButton.enabled = YES;
                    [self.eat_PrizeButton setBackgroundImage:IMG(@"unprize") forState:UIControlStateNormal];
                }
                
            }
            
        }
        else
        {
            self.eat_PrizeButton.hidden = YES;
            self.eat_scroLabel.hidden = NO;
            self.eat_scroLabel.text = [NSString stringWithFormat:@"积分:%ld",(long)data.data.score];
        }
        
    }
   
}


/**
 *  设置走路cell的数据
 */

- (void)setContentForWalkCell:(GetRunningDataAck *)data
{
    if (!data)
    {
        return;
    }
    
    [self resetWalkSteps:data.data.step];

    
    self.walk_Title.text = data.data.name;
    [self.walk_TitleImage sd_setImageWithURL:[NSURL URLWithString:data.data.icon] placeholderImage:nil];
    self.walk_maxSetpLabel.text = [NSString stringWithFormat:@"%ld步",(long)data.data.targetStep];
    
    if (!data.data.targetStep || data.data.targetStep == 0)
    {
         [self.walk_progressView setProgress:0 animated:YES];
    }
    else
    {
        CGFloat progress = (CGFloat)data.data.step / (CGFloat)data.data.targetStep;
        progress = progress >= 1.0 ? 1.0 : progress;
        [self.walk_progressView setProgress:progress animated:YES];
    }
    
    
    
    if (data.data.isOK)
    {
        self.walk_Score.hidden = YES;
        self.walk_PrizeButton.hidden = NO;
        
        if (data.data.flag)
        {
            self.walk_PrizeButton.enabled = NO;
            [self.walk_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
        }
        else
        {
            
            if (bHistroyDay)
            {
                self.walk_Score.hidden = NO;
                self.walk_PrizeButton.hidden = YES;
                self.walk_Score.text = [NSString stringWithFormat:@"积分:%ld",(long)data.data.score];
            }
            else
            {
                self.walk_PrizeButton.enabled = YES;
                [self.walk_PrizeButton setBackgroundImage:IMG(@"unprize") forState:UIControlStateNormal];
            }
            
        }
        
    }
    else
    {
        self.walk_Score.hidden = NO;
        self.walk_PrizeButton.hidden = YES;
        self.walk_Score.text = [NSString stringWithFormat:@"积分:%ld",(long)data.data.score];
    }
}


/**
 *  设置健康日记的数据
 */

- (void)setContentForContextCell:(GetDiaryDataByDayAck *)data
{
    if (!data)
    {
        return;
    }
    
    self.context_Title.text = data.data.name;
    [self.context_HeadImage sd_setImageWithURL:[NSURL URLWithString:data.data.icon] placeholderImage:nil];
    
    if (bHistroyDay)
    {
        
        if (data.data.isOK)
        {
            self.mDirayView.hidden = YES;
            self.context_WirteBtn.hidden = YES;
            self.context_Image.hidden = NO;
            self.context_Lable.hidden = NO;
            
            [self.context_Image dd_setImageURL:[NSURL URLWithString:[UIKitTool getRawImage:data.data.picAddr]]];
            
            self.context_Lable.font                 = [UIFont systemFontOfSize:16.0f];
            self.context_Lable.numberOfLines        = 0;
            self.context_Lable.isNeedAtAndPoundSign = YES;
            self.context_Lable.lineBreakMode = NSLineBreakByTruncatingHead;
            self.context_Lable.customEmojiRegex     = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
            self.context_Lable.customEmojiPlistName = @"expression.plist";
            self.context_Lable.text = [data.data.content URLDecodedForString];
            self.context_Lable.text = [data.data.content URLDecodedForString];


            self.context_score.hidden = YES;
            self.context_PrizeButton.hidden = NO;
            
            if (data.data.flag)
            {
                [self.context_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
                self.context_PrizeButton.enabled = NO;
            }
            else
            {
                self.context_PrizeButton.hidden = YES;
                self.context_score.text = [NSString stringWithFormat:@"积分:%ld",(long)data.data.score];
                self.context_score.hidden = NO;
            }
        }
        else
        {
            self.context_Image.hidden = YES;
            self.context_Lable.hidden = YES;
            
            [self.mDirayView setContextText:@"这天你什么都没写" withImage:IMG(@"noDiary")];
            self.mDirayView.hidden = NO;
            [self bringSubviewToFront:self.mDirayView];
            
            self.context_PrizeButton.hidden = YES;
            self.context_score.text = [NSString stringWithFormat:@"积分:%ld",(long)data.data.score];
            self.context_score.hidden = NO;
        }
    }
    else
    {
        self.mDirayView.hidden = YES;
        
        if (data.data.isOK)
        {
            self.context_WirteBtn.hidden = YES;
            self.context_Image.hidden = NO;
            self.context_Lable.hidden = NO;
            
            [self.context_Image dd_setImageURL:[NSURL URLWithString:[UIKitTool getRawImage:data.data.picAddr]]];
            
            
            self.context_Lable.text = [data.data.content URLDecodedForString];
            
            self.context_score.hidden = YES;
            self.context_PrizeButton.hidden = NO;
            
            if (data.data.flag)
            {
                [self.context_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
                self.context_PrizeButton.enabled = NO;
            }
            else
            {
                self.context_PrizeButton.enabled = YES;
                [self.context_PrizeButton setBackgroundImage:IMG(@"unprize") forState:UIControlStateNormal];
            }
        }
        else
        {
            self.context_WirteBtn.hidden = NO;
            self.context_PrizeButton.hidden = YES;
            self.context_score.text = [NSString stringWithFormat:@"积分:%ld",(long)data.data.score];
            self.context_score.hidden = NO;
            
            self.context_Lable.hidden = YES;
            self.context_Image.hidden = YES;
        }
    }
}

/**
 *  设置运动cell的数据
 */

- (void)setContentForSportCell:(GetSportDataByDayAck *)data  inStrongScheme:(BOOL)bShow
{
    
    if (!data)
    {
        return;
    }
    
    if (!bShow)
    {
        [self.mLockView setContextText:@"进入强化阶段后\n将解锁该神秘任务" withImage:IMG(@"unlock_scheme")];
        self.mLockView.hidden = NO;
        [self bringSubviewToFront:self.mLockView];
    }
    else
    {
        self.mLockView.hidden = YES;
        self.sport_Title.text = data.data.name;
        [self.sport_HeadImage sd_setImageWithURL:[NSURL URLWithString:data.data.icon] placeholderImage:nil];
        
        self.sport_Label.text = data.data.title;
        
        if (data.data.isOK)
        {
            self.sport_PrizeButton.hidden = NO;
            self.sport_Score.hidden = YES;
            if (data.data.flag)
            {
                self.sport_PrizeButton.enabled = NO;
                [self.sport_PrizeButton setBackgroundImage:IMG(@"prize") forState:UIControlStateNormal];
            }
            else
            {
                self.sport_PrizeButton.enabled = YES;
                [self.sport_PrizeButton setBackgroundImage:IMG(@"unprize") forState:UIControlStateNormal];
            }
            
        }
        else
        {
            self.sport_PrizeButton.hidden = YES;
            self.sport_Score.hidden = NO;
            
            self.sport_Score.text = [NSString stringWithFormat:@"积分:%ld",(long)data.data.score];
        }
    }
    
}


/**
 *  设置更多功能的Cell的数据
 */

- (void)setContentForMoreCell:(GetSchemeDayInfoAck *)listData
{
    NSInteger unreadCount = listData.data.tieBaUnreadCount;
    [self.more_newsItem setLocalImage:IMG(@"health_news") andText:@"健康资讯"];
    [self.more_newsItem addTarget:self selector:@selector(newsEvent) withObject:nil];
    [self.more_forumItem setLocalImage:IMG(@"forum") andText:@"交流论坛"];
    if (unreadCount > 99) {
        self.more_forumItem.tieBarUnreadLabel.text = @"99+";
    }
    else{
        self.more_forumItem.tieBarUnreadLabel.text = [NSString stringWithFormat:@"%ld", (long)unreadCount];
    }
    [self.more_forumItem addTarget:self selector:@selector(forumEvent) withObject:nil];
    [self.more_tipsItem setLocalImage:IMG(@"ideas") andText:@"锦囊妙计"];
    [self.more_tipsItem addTarget:self selector:@selector(cleverTipsEvent) withObject:nil];
}

#pragma mark -
#pragma mark 计算Cell的高度

+ (CGFloat)heightForHealthCell:(id)data atIndexPath:(NSIndexPath *)indexPath
{
    
    if (!data)
    {
        if (indexPath.section == 5)
        {
            return 96.0;
        }
        return 0.0;
    }
    else
    {
        if (indexPath.section == 0)
        {
            return 188.0;
        }
        else if (indexPath.section == 1)
        {
            return 305.0;
        }
        else if (indexPath.section == 2)
        {
            return 140.0;
        }
        else if (indexPath.section == 3)
        {
            GetDiaryDataByDayAck * contentData = (GetDiaryDataByDayAck *)data;
            
            if (contentData.data.isOK)
            {
                //根据文本和图片计算高度
                CGFloat height = [UIKitTool heightForCell:[contentData.data.content URLDecodedForString] withFont:16.0 withWidth:kScreenWidth - 63];
                if ([contentData.data.picAddr isEqualToString:@""] || !contentData.data.picAddr)
                {
                    return height + 75;
                }
                else
                {
                    return height + 180;
                }
            }
            else
            {
                return 140.0;
            }
        }
        else if (indexPath.section == 4)
        {
            return 135.0;
        }
        else
        {
            return 96.0;
        }
    }
}


#pragma mark - 
#pragma mark HFFoodCardViewDelegate

- (void)pushMealsDetail:(NSInteger)mealType
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:eat_Event withObject:@(mealType)];
    }
}

#pragma mark -
#pragma mark HFCoverFlowViewDelegate

- (void)coverFlowSelectedAtIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(daysCoverSelect:)])
    {
        [_delegate daysCoverSelect:index];
    }
}

#pragma mark -
#pragma mark getter

- (HFMixView *)mLockView
{
    if (!_mLockView)
    {
        _mLockView = [[HFMixView alloc] init];
        _mLockView.mType = verticalType;
        _mLockView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mLockView];
        [_mLockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 1, 0));
        }];
    }
    return _mLockView;
}

- (HFMixView *)mDirayView
{
    if (!_mDirayView)
    {
        _mDirayView = [[HFMixView alloc] init];
        _mDirayView.mType = verticalType;
        _mDirayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mDirayView];
        
        [_mDirayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(40, 0, 2, 0));
        }];
    }
    return _mDirayView;
}


#pragma mark -
#pragma makr - Event

/**
 *  写日记
 *
 */
- (IBAction)writeContextAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:context_Write_Event withObject:nil];
    }
}

- (IBAction)sportPrizeAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:sport_Prize_Event withObject:nil];
    }
}

- (IBAction)eatPrizeAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:eat_Prize_Event withObject:nil];
    }
}

- (IBAction)walkPrizeAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:walk_Prize_Event withObject:nil];
    }
}

- (IBAction)contextPrizeAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:context_Prize_Event withObject:nil];
    }
}

- (IBAction)unableWalkStep:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:walk_unable_Event withObject:nil];
    }
}

/**
 *  运动一下按钮
 */
- (IBAction)sportAction:(UIButton *)sender
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:sport_Event withObject:nil];
    }
}



/**
 *  锦囊妙计的按钮
 */
- (void)cleverTipsEvent
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:more_tips_Event withObject:nil];
    }
    
}

/**
 *  贴吧的按钮
 *
 */
- (void)forumEvent
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:more_forum_Event withObject:nil];
    }
}

/**
 *  咨询交流的按钮
 *
 */
- (void)newsEvent
{
    if (_delegate && [_delegate respondsToSelector:@selector(healthCellReponseEvent:withObject:)])
    {
        [_delegate healthCellReponseEvent:more_news_Event withObject:nil];
    }
}

@end
