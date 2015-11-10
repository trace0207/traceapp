//
//  ModuleHeader.h
//  GuanHealth
//
//  Created by hermit on 15/4/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommonItem.h"

@interface ModuleHeader : UIView<UIGestureRecognizerDelegate>
{
    NSInteger changedTag;
    CGPoint endPoint;
    CGPoint toPoint;
}

@property (nonatomic, strong)  NSMutableArray  *modulesCopyArray;

@property (nonatomic, strong) UILabel *backView;
@property (nonatomic, strong) UIButton    *sortBtn;

- (instancetype)initWithFrame:(CGRect)frame withObsreve:(id)observe andHiModule:(NSArray*)modules;

- (void)addOneModule:(ModelData*)module withObserver:(id)observer;

- (void)removeOneModule:(NSUInteger)tag;

- (void)refreshDataWithObserver:(id)observer andHiModules:(NSArray *)modules;

@end