//
//  HFReportView.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseView.h"
#import "PostDetailData.h"

@interface HFReportView : BaseView
{
    NSInteger currentIndex;
}

@property (nonatomic, strong) PostDetailData *data;
@property (nonatomic, weak) IBOutlet UIButton *reportBtn;
@property (nonatomic, weak) IBOutlet UIView *bgView;
- (IBAction)cancelAction:(id)sender;
- (IBAction)reportAction:(id)sender;
- (IBAction)selectAction:(UIButton *)btn;

@end
