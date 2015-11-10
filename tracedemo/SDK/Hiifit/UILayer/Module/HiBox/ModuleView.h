//
//  ModuleView.h
//  GuanHealth
//
//  Created by hermit on 15/4/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiModuleListData.h"

@interface ModuleView : UIView

@property (nonatomic, strong) UIImageView *moduleImageView;
@property (nonatomic, strong) UILabel     *moduleNameLabel;
@property (nonatomic, strong) UIButton    *addBtn;
@property (nonatomic, strong) UIButton    *detailBtn;


- (void)setValue:(HiModuleListData*)module;

@end
