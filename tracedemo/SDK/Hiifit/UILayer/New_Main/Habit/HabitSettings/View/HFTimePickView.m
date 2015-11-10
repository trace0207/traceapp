//
//  HFTimePickView.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFTimePickView.h"
#import "RBCustomDatePickerView.h"
@implementation HFTimePickView


- (id)init
{
    self = [super init];
    if (self)
    {
        [self loadUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 80, 14)];
    label.text = _T(@"HF_Habit_Time_Settings");
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    
    RBCustomDatePickerView *pickerView = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, label.frame.size.height, self.frame.size.width, self.frame.size.height - label.frame.size.height)];
    [self addSubview:pickerView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
