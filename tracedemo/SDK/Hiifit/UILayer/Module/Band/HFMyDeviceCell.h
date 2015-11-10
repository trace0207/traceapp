//
//  HFMyDeviceCell.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/29.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@interface HFMyDeviceCell : BaseTableCell

@property (weak, nonatomic) IBOutlet UIImageView *deviceImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bindLabel;

@end
