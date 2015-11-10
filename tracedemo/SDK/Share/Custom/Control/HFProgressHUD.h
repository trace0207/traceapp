//
//  HFProgressHUD.h
//  MBProgressHUD
//
//  Created by zhuxiaoxia on 15/8/10.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import "MBProgressHUD.h"

@interface HFProgressHUD : MBProgressHUD
@property (atomic, MB_STRONG) UIView *indicator;
@end

@interface HFRoundProgressView : MBRoundProgressView
{
    UILabel *progressLabel;
}

@end
