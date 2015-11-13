//
//  HFNewMainViewController.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/10/19.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "BaseViewController.h"

//首页的组织架构
typedef NS_ENUM(NSInteger, NewMainOrganization)
{
    HFNewMainCellOrganization_Banner = 0,
    HFNewMainCellOrganization_Other,
};

typedef NS_ENUM(NSInteger, NewMainFunction)
{
    HFNewMainCellFunc_Scheme = 0,
    HFNewMainCellFunc_Habit,
};

@interface HFNewMainViewController : BaseViewController

@end
