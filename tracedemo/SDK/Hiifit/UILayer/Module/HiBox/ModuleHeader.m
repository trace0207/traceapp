//
//  ModuleHeader.m
//  GuanHealth
//
//  Created by hermit on 15/4/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ModuleHeader.h"

@implementation ModuleHeader

- (instancetype)initWithFrame:(CGRect)frame withObsreve:(id)observe andHiModule:(NSArray*)modules;
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    headLabel.text = @"我的嗨盒";
    headLabel.font = [UIFont systemFontOfSize:14.0f];
    headLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:headLabel];
    
    _sortBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 60, 0, 60, 40)];
    [_sortBtn setTitle:@"排序" forState:UIControlStateNormal];
    [_sortBtn setTitle:_T(@"HF_Common_Finish") forState:UIControlStateSelected];
    [_sortBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_sortBtn setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    [self addSubview:_sortBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 0.5f)];
    line.backgroundColor = [UIColor HFColorStyle_6];
    [self addSubview:line];
    
    _backView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    _backView.text = @"点击“＋”添加模块";
    _backView.center = CGPointMake(kScreenWidth/2, 40 + ItemWidth/2);
    _backView.textAlignment = NSTextAlignmentCenter;
    _backView.font = [UIFont systemFontOfSize:14.0f];
    _backView.textColor = [UIColor lightGrayColor];
    [self addSubview:_backView];
    self.backgroundColor = [UIColor whiteColor];
    [self addModules:observe andModules:modules];
    
    return self;
}

- (void)refreshDataWithObserver:(id)observer andHiModules:(NSArray *)modules
{
    for (NSUInteger i = 0; i < modules.count; i++) {
        UIView *view = [self viewWithTag:100 +i];
        if (view) {
            [view removeFromSuperview];
        }
        if (i == modules.count - 1) {
            [self addModules:observer andModules:modules];
        }
    }
}

- (void)addModules:(id)observer andModules:(NSArray *)modules
{
    if (modules.count <= 0) {
        _backView.hidden = NO;
    }else{
        _backView.hidden = YES;
        for (NSInteger i = 0; i < modules.count; i++) {
            ModelData *model = [modules objectAtIndex:i];
            CommonItem *item = [[CommonItem alloc]initWithFrame:CGRectMake((i%kConItems) * ItemWidth, (i/kConItems) * ItemWidth + 41.0f, ItemWidth, ItemWidth)];
            item.tag = 100 + i;
            item.delegate = observer;
            [item setContentToCell:model];
            [self addSubview:item];
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
            pan.delegate = self;
            [item addGestureRecognizer:pan];
        }
    }
}

- (void)addOneModule:(ModelData*)module withObserver:(id)observer
{
    _backView.hidden = YES;
    CGRect rect = CGRectMake((abs((int)self.modulesCopyArray.count-1)%kConItems) * ItemWidth, (abs((int)self.modulesCopyArray.count-1)/kConItems) * ItemWidth + 41.0f, ItemWidth, ItemWidth);
    CommonItem *item = [[CommonItem alloc]initWithFrame:rect];
    [item setContentToCell:module];
    item.tag = 100 + self.modulesCopyArray.count - 1;
    item.delegate = observer;
    self.frame = CGRectMake(0, 0, kScreenWidth, 41 + ItemWidth + (abs((int)self.modulesCopyArray.count-1)/kConItems)*ItemWidth);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    [item addGestureRecognizer:pan];
    pan.delegate = self;
    [self addSubview:item];
}

- (void)removeOneModule:(NSUInteger)tag
{
    if (self.modulesCopyArray.count == 0) {
        _backView.hidden = NO;
    }
    UIView *view = [self viewWithTag:tag];
    [view removeFromSuperview];
    self.frame = CGRectMake(0, 0, kScreenWidth, 40 + ItemWidth + (abs((int)self.modulesCopyArray.count-1)/kConItems)*ItemWidth);
    for (NSInteger i = tag + 1; i <= self.modulesCopyArray.count + 100; i++) {
        CommonItem *it = (CommonItem*)[self viewWithTag:i];
        if (!it) {
            return;
        }
        
        //WS(weakSelf);
        [UIView animateWithDuration:0.15f animations:^{
            if ((it.tag - 100)%kConItems == 0) {
                it.center = CGPointMake(kScreenWidth - ItemWidth/2, it.center.y - ItemWidth);
            }else{
                it.center = CGPointMake(it.center.x - ItemWidth, it.center.y);
            }
            
        } completion:^(BOOL finished) {
            it.tag = it.tag - 1;
        }];
    }
}

- (void)dealloc
{
    self.modulesCopyArray = nil;
}

- (void)panHandle:(UIPanGestureRecognizer*)recognizer
{
//    if (_sortBtn.selected == NO) {
//        return;
//    }
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [recognizer.view bringToFront];
        endPoint = recognizer.view.center;
    }
    CGPoint translation = [recognizer translationInView:self];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        for (NSUInteger i = 0; i < self.modulesCopyArray.count; i++) {
            if (recognizer.view.tag != i+100) {
                CommonItem *view = (CommonItem*)[self viewWithTag:i+100];
                changedTag = view.tag;
                CGFloat distance = (view.center.x - recognizer.view.center.x)*(view.center.x - recognizer.view.center.x) + (view.center.y - recognizer.view.center.y)*(view.center.y - recognizer.view.center.y);
                if (distance < view.frame.size.width/2*view.frame.size.width/2) {
                    endPoint = view.center;
                    NSInteger startIndex = 0;
                    NSInteger endIndex = 0;
                    
                    if (recognizer.view.tag > view.tag) {
                        startIndex = view.tag;
                        endIndex = recognizer.view.tag - 1;
                    }else{
                        startIndex = recognizer.view.tag + 1;
                        endIndex = view.tag;
                    }
                    
                    for (NSInteger j = startIndex; j <= endIndex; j++) {
                        CommonItem *subView = (CommonItem*)[self viewWithTag:j];
                            //[_views addObject:subView];
                        if (recognizer.view.tag > subView.tag) {
                            if (subView.center.x < view.frame.size.width*(kConItems-1)) {
                                toPoint = CGPointMake(subView.center.x + view.frame.size.width, subView.center.y);
                            }else{
                                toPoint = CGPointMake(view.frame.size.width/2, subView.center.y + view.frame.size.height);
                            }
                            subView.tag = subView.tag + 1;
                        }else{
                            if (subView.center.x > view.frame.size.width) {
                                toPoint= CGPointMake(subView.center.x - view.frame.size.width, subView.center.y);
                            }else{
                                toPoint =CGPointMake(view.frame.size.width*(kConItems-1) + view.frame.size.width/2, subView.center.y - view.frame.size.height);
                            }
                            subView.tag = subView.tag - 1;
                        }
                        [UIView animateWithDuration:0.2f animations:^{
                            subView.center = toPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }
                    
                    recognizer.view.tag = changedTag;
                }
            }
        }
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2f animations:^{
            recognizer.view.center = endPoint;
        }];
        for (NSUInteger k = 0; k < self.modulesCopyArray.count; k++) {
            CommonItem *item = (CommonItem*)[self viewWithTag:k + 100];
            for (NSUInteger l = 0; l < self.modulesCopyArray.count; l++) {
                ModelData *module = [self.modulesCopyArray objectAtIndex:l];
                if (module.modelId == item.itemId && k != l) {
                    [self.modulesCopyArray exchangeObjectAtIndex:k withObjectAtIndex:l];
                }
            }
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer.view isKindOfClass:[UITableView class]] && _sortBtn.selected == NO) {
        return YES;
    }
    if ([gestureRecognizer.view isKindOfClass:[UITableView class]] && _sortBtn.selected == YES) {
        return NO;
    }
    if (_sortBtn.selected == YES) {
        if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            return NO;
        }
    }else{
        if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            return NO;
        }
    }
    return YES;
}

@end
