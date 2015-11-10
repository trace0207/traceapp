//
//  BTScrollViewController.h
//  LaiWen
//
//  Created by hermit on 14-8-13.
//  Copyright (c) 2014年 BeanTink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@protocol BTScrollViewDelegate;
@interface BTScrollViewController : UIViewController<UIScrollViewDelegate>
{
    UIView *indicatorView;
    CGFloat lastOffset_x;
    CGFloat lastLineCenter_x;
}

@property (retain, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (retain, nonatomic) NSArray *ContentArray;

@property (retain, nonatomic) UIColor *indicatorColor;

@property (retain, nonatomic) UIColor *headerColor;

@property (retain, nonatomic) UIColor *selectTextColor;

@property (retain, nonatomic) UIColor *unselectTextColor;

@property (assign, nonatomic) CGFloat headerHeight;

@property (assign, nonatomic) CGFloat headerWidth;

@property (retain, nonatomic) UILabel *badgeLabel;

@property (assign, nonatomic, readonly) NSInteger currentIndex;

@property (weak, nonatomic) id<BTScrollViewDelegate>BTScrolldelegate;

@property (nonatomic)  BOOL hasSeperatorLine;

- (void)switchMessageTipState:(BOOL)show atIndex:(NSInteger)index;

@end


@protocol BTScrollViewDelegate <NSObject>

@optional

- (void)ScrollAtIndex:(NSInteger)index;

@end