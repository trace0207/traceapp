//
//  TK_menuViewVC.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/24.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TK_menuViewVCDelegate <NSObject>

@optional
- (CGFloat)heightForCell;

@required
- (void)menuDidSelectIndex:(NSInteger)index withTempData:(NSObject * )data;

@end

@interface TK_menuViewVC : UIView


@property (nonatomic, weak) id<TK_menuViewVCDelegate>delegate;
@property (nonatomic, weak) NSObject * tempdata;// 用来缓存数据的

- (instancetype)initWithCategorys:(NSMutableArray *)categorys;

- (void)showMenu:(CGPoint)point;

- (void)hidWithAnima:(BOOL)ani;

@end
