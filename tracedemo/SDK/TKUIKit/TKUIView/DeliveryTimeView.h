//
//  DeliveryTimeView.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/21.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BaseView.h"

@interface DeliveryTimeView : BaseView

@property (nonatomic, strong) IBOutlet UILabel *expectLabel;//买家期望时间
@property (nonatomic, strong) IBOutlet UILabel *actualLabel;//商家允诺发货时间

@property (nonatomic, strong) IBOutlet UIButton *oneBtn;//1天发货
@property (nonatomic, strong) IBOutlet UIButton *threeBtn;//3天发货
@property (nonatomic, strong) IBOutlet UIButton *sevenBtn;//7天发货
@property (nonatomic, strong) IBOutlet UIButton *hasReadBtn;//已读按钮
@property (nonatomic, strong) IBOutlet UIButton *ruleBtn;//发货规则按钮
@property (nonatomic, strong) IBOutlet UIButton *onShowBtn;//不再显示按钮
@property (nonatomic, strong) IBOutlet UIButton *leftBtn;//继续晒单按钮
@property (nonatomic, strong) IBOutlet UIButton *rightBtn;//关闭按钮

@property (nonatomic, assign) int expectDays;

- (IBAction)chooseDate:(UIButton *)button;
- (IBAction)hasReadAction:(UIButton *)button;
- (IBAction)donotShowAction:(UIButton *)button;
- (IBAction)fahuoRule:(UIButton *)button;

@end
