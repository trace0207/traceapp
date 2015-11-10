//
//  HFSchemeCell.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/31.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseTableCell.h"
#import "HFProgressView.h"
#import "LoadSchemeInfoAck.h"
#import "HFGuideView.h"

@interface HFSchemeCell : BaseTableCell

@property (nonatomic, weak) IBOutlet HFProgressView *progressView;

@property (nonatomic, weak) IBOutlet UIImageView    *iconView;

@property (nonatomic, weak) IBOutlet UILabel        *pastDaysLabel;
@property (nonatomic, weak) IBOutlet UILabel        *accessLabel;
@property (nonatomic, weak) IBOutlet UILabel        *nextDaysLabel;
@property (nonatomic, weak) IBOutlet UILabel        *peopleNumLabel;
@property (nonatomic, weak) IBOutlet UILabel        *crowdLabel;
@property (nonatomic, weak) IBOutlet UILabel        *schemeLabel;
@property (nonatomic, weak) IBOutlet UILabel        *contentLabel;

@property (nonatomic, weak) IBOutlet UIButton       *useBtn;

@property (nonatomic, weak) IBOutlet UIButton       *infoBtn;
@property (weak, nonatomic) IBOutlet HFGuideView    *guideView;

- (void)setContent:(LoadSchemeDataAck *)info;

@end
