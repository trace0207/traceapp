//
//  ModifyViewController.h
//  GuanHealth
//
//  Created by hermit on 15/3/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, GZModifyType)
{
    GZModifyPortrait        = 0,
    GZModifyNickname        = 1,
    GZModifyTypeSex         = 2,
    GZModifyTypeAge         = 3,
    GZModifyHeight          = 4,
    GZModifyWeight          = 5,
    GZModifySignature       = 6,
    GZModifyBangding        = 7,
    GZModifyBand            = 8,
};

@interface ModifyViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UITextField    *infoTextField;
@property (nonatomic, weak) IBOutlet UIView         *line;
@property (nonatomic, assign)        GZModifyType   modyfyType;

@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayPicker;
- (IBAction)birthdayValueChanged:(UIDatePicker *)sender;


@end
