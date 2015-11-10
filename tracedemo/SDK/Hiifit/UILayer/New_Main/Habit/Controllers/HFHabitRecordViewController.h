//
//  HFHabitRecordViewController.h
//  GuanHealth
//
//  Created by hermit on 15/6/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HabitProxy.h"
#import "BaseViewController.h"
@protocol HFPunchCardDelegate <NSObject>
@optional
- (void)PunchCard:(NSInteger)habitId withStatus:(NSInteger)status;

@end

@interface HFHabitRecordViewController : BaseViewController
@property (nonatomic, strong)  UIViewController *popViewController;
@property (nonatomic, copy)  NSString *habitName;
@property (nonatomic, assign)NSInteger habitId;
@property (nonatomic, copy)  NSString *habitIconUrl;
@property (nonatomic, copy) NSString * habitNote;
@property (nonatomic, weak) id<HFPunchCardDelegate>delegate;

@property (nonatomic, strong) HFHabitSignInfoData *infoData;

@property (nonatomic,weak) IBOutlet UILabel *allLabel;
@property (nonatomic,weak) IBOutlet UILabel *continuousLabel;
@property (nonatomic,weak) IBOutlet UILabel * subPeopleLabel;
@property (nonatomic,weak) IBOutlet UIButton *recordBtn;
@property (nonatomic,weak) IBOutlet UIButton *sentPostBtn;

@property (nonatomic, strong) IBOutlet UIView *headerView;

@property (nonatomic, strong) IBOutlet UIView *addHeaderView;
@property (nonatomic, weak) IBOutlet UILabel *habitNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *peopleNumLabel;
@property (nonatomic, weak) IBOutlet UIImageView * mIconView;

@property (nonatomic, weak) IBOutlet  UILabel * habitNoteLabel;

- (IBAction)recordAction:(UIButton*)sender;
- (IBAction)goSentViewAction:(UIButton*)sender;
- (IBAction)addHabitAction:(id)sender;

@end


