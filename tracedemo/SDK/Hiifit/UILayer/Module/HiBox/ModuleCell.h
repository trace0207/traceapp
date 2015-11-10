//
//  ModuleCell.h
//  GuanHealth
//
//  Created by hermit on 15/4/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleView.h"
#define kModuleWidth  (kScreenWidth - 20.0f)/3.0f
#define kModuleHeight kModuleWidth*1.28f



@protocol ModuleDelegate <NSObject>

- (void)addOrDeleteModuleModuleId:(NSInteger)moduleId isDelete:(BOOL)del;

- (void)seeModuleDetailModuleId:(NSInteger)moduleId;

@end

@interface ModuleCell : UITableViewCell

@property (nonatomic, strong) ModuleView *view1;
@property (nonatomic, strong) ModuleView *view2;
@property (nonatomic, strong) ModuleView *view3;
@property (nonatomic, weak)   id<ModuleDelegate>delegate;

- (void)setValuefirstMod:(HiModuleListData*)module1
            andSecondMod:(HiModuleListData*)module2
             andThirdMod:(HiModuleListData*)module3;

@end
