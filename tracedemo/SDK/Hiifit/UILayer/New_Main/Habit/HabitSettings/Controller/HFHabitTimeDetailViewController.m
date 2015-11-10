//
//  HFHabitTimeDetailViewController.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitTimeDetailViewController.h"
#import "HFHabitInfoCell.h"
#import "RBCustomDatePickerView.h"
#import "HFWeekdaySelectView.h"
#import "HabitProxy.h"
#import "HFHabitHelper.h"
#import "HFHabitRecordViewController.h"

@interface HFHabitTimeDetailViewController ()<HFWeekdaySelectViewDelegate,RBCustomDatePickerViewDelegate>
{
    NSDate * mDate;
    
    NSMutableArray * mWeekDays;
    
    RBCustomDatePickerView * mPickerView;
}
@end

@implementation HFHabitTimeDetailViewController
@synthesize data;
@synthesize mHabitId;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (IOS7_OR_LATER) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.modalPresentationCapturesStatusBarAppearance= NO;
    }
    
    [self addNavigationTitle:@"设置提醒"];
    [self addRightBarItemWithTitle:_T(@"HF_Common_Finish")];
    self.view.backgroundColor = [UIColor HFColorStyle_6];
    [self loadDatSource];
    [self loadUI];
    // Do any additional setup after loading the view.
}

- (void)rightBarItemAction:(id)sender
{
    [self save];
}

- (BOOL)CheckEffective
{
    if ([data.weeks isEqualToString:@"0000000"])
    {
        return NO;
    }
    return YES;
}

- (void)save
{
    
    if (![self CheckEffective])
    {
        [[HFHUDView shareInstance] ShowTips:_T(@"HF_Habit_Weeks_Settings") delayTime:1.0 atView:nil];
        return;
    }
    
    
    if (self.mType == CreateHabit_Type)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(finishAction:)])
        {
            [_delegate finishAction:self.data];
            
            [self back];
        }
        
        return;
    }
   
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    //此处要去保存接口
    WS(weakSelf)
    
    switch (self.mType)
    {
        case AddHabit_Type:
        {
            [[[HIIProxy shareProxy]habitProxy]addHabitWithHabitId:mHabitId andData:data completion:^(BOOL finish) {
                [hud hide:YES];
                if (finish) {
                    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addHabitSuccess:)]) {
                        [weakSelf.delegate addHabitSuccess:mHabitId];
                        [mPickerView back];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }else {
                    DDLogInfo(@"添加习惯失败!");
                }
            }];
        }
            break;
        case AddNewClock_Type:
        {
            [[[HIIProxy shareProxy] habitProxy] addAlarmClockWithAlarmClockData:data habitID:mHabitId completion:^(BOOL finish) {
                if (finish)
                {
                    //本地去插入一条新数据
                    //                    [[HFHabitHelper shareInstance] addNewData:data habitId:mHabitId habitName:mHabitName];
                    [hud hide:YES];
                    [weakSelf back];
                }
                else
                {
                    [hud hide:YES];
                    DDLogInfo(@"新增闹钟失败!");
                }
            }];
        }
            break;
        case UpdataClock_Type:
        {
            [[[HIIProxy shareProxy] habitProxy] updateAlarmClockWithAlarmClockData:data habitID:mHabitId completion:^(BOOL finish) {
                if (finish)
                {
                    //本地去更新一条新数据
                    //                  [[HFHabitHelper shareInstance] updateData:data habitId:mHabitId habitName:mHabitName];
                    [hud hide:YES];
                    [weakSelf back];
                }
                else
                {
                    [hud hide:YES];
                    DDLogInfo(@"更新闹钟失败!");
                }
            }];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)back
{
    [mPickerView back];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadDatSource
{
    //转成Date时间
    NSString * dateStr = [NSString stringWithFormat:@"%02ld%02ld",(long)data.hour,(long)data.minute];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmm"];
    mDate = [formatter dateFromString:dateStr];
    
    //获取重复weeks的数组
    if (!mWeekDays)
    {
        mWeekDays = [[NSMutableArray alloc] init];
    }
    
    [self transArrayFormString:data.weeks];
}

- (void)loadUI
{
    //初始化界面

    if (!data)
    {
        data = [[HFHabitAlramClockListData alloc] init];
        
        data.weeks = @"1111111";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HHmm"];
        NSString * dateStr = [formatter stringFromDate:date];
        
        data.hour = [[dateStr substringWithRange:NSMakeRange(0, 2)] integerValue];
        data.minute = [[dateStr substringWithRange:NSMakeRange(2, 2)] integerValue];
        
        //其实进入到这里面的只有两种情形
        if (self.mType == AddHabit_Type)
        {
            data.status = NO;
        }
        else if (self.mType == AddNewClock_Type)
        {
            data.status = YES;
        }
    }
    
    UIView * remindView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    remindView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:remindView];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 80, 20)];
    title.textColor = [UIColor HFColorStyle_1];
    title.text = @"提醒";
    [remindView addSubview:title];
    
    UISwitch * swi = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 65, 15, 50, 30)];
    swi.onTintColor = [UIColor HFColorStyle_5];
    swi.on = data.status;
    [swi addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [remindView addSubview:swi];

    
    mPickerView = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, remindView.frame.size.height, self.view.frame.size.width, 240)];
    mPickerView.delegate = self;
    mPickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mPickerView];
    [mPickerView setTimeBroadcastView];
    
    HFWeekdaySelectView * weekdayView = [[HFWeekdaySelectView alloc] initWithFrame:CGRectMake(0, mPickerView.frame.origin.y + mPickerView.frame.size.height + 0.5, self.view.frame.size.width, 120)];
    weekdayView.backgroundColor = [UIColor whiteColor];
    weekdayView.delegate = self;
    [self.view addSubview:weekdayView];
    [weekdayView reloadData:mWeekDays];
    
}

- (void)transArrayFormString:(NSString *)weeks
{
    for (int i = 0; i < weeks.length; i++)
    {
        NSString * str = [weeks substringWithRange:NSMakeRange(i, 1)];
        [mWeekDays addObject:str];
    }
}

- (void)switchAction:(UISwitch *)swi
{
    self.data.status = swi.on;
}


#pragma mark -
#pragma mark RBCustomDatePickerViewDelegate
- (NSString *)showTimeString
{
 
    NSString * timeStr = [NSString stringWithFormat:@"%02ld%02ld",(long)data.hour,(long)data.minute];
    return timeStr;

}

- (void)setTimeHour:(NSInteger)hour min:(NSInteger)min
{
    data.hour = hour;
    data.minute = min;
}

#pragma mark -
#pragma mark HFWeekdaySelectViewDelegate
- (void)weekSelectAction:(NSInteger)index selectedState:(BOOL)selected
{
    NSString * newFlag;
    if (selected)
    {
        newFlag = @"1";
    }
    else
    {
        newFlag = @"0";
    }
    
    NSInteger location =  index == 0 ? 6 : index - 1;
    
    NSMutableString * str = [[NSMutableString alloc] initWithString:data.weeks];
    [str replaceCharactersInRange:NSMakeRange(location, 1) withString:newFlag];
    data.weeks = str;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
