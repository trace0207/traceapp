//
//  TK_menuViewVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/24.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_menuViewVC.h"
#import "HFMenuControl.h"
#import "HFMenuCell.h"
#import "UIImage+Scale.h"
#import "Masonry.h"
#import "UIColor+TK_Color.h"
#import "Masonry.h"

static CGFloat DefaultMenuWidth = 130;
//static CGFloat DefaultButtonWidth = 65;
static CGFloat DefaultMenuHeight = 36;

//static CGFloat MenuCellWidth = 80;

@interface TK_menuViewVC ()
{
    NSMutableArray *titlesArray;
    CGRect menuRect;
    NSInteger currentSelect; // 当前选中的类目
    UIView * contentView; // 显示menu的容器  控制显示区
    UIView * showContentView; // menu的容器
    UIView * eventResponseAreaView;  // 事件响应的区域
    CGFloat  centerX;
    CGFloat  centerY;
    BOOL isShow; // 是否触发了show动作， 解决 show  hid 过程中 再shou的异步问题
    
}

@property (strong, nonatomic) UITableView *mTableView;
@property (assign, nonatomic) CGFloat mMenuHeight;
@property (strong, nonatomic) NSArray * btns;

@end

@implementation TK_menuViewVC


-(instancetype)init{

    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    UIButton *hiddenBtn = [[UIButton alloc]initWithFrame:self.frame];
//    [hiddenBtn addTarget:self action:@selector(hiddenAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hiddenBtn];
    
    
    eventResponseAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DefaultMenuWidth *2, DefaultMenuHeight * 2)];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DefaultMenuWidth, DefaultMenuHeight)];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.clipsToBounds = YES;
    
    showContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DefaultMenuWidth, DefaultMenuHeight)];
    
    showContentView.layer.cornerRadius = 8.0f;
    showContentView.layer.masksToBounds = YES;
    showContentView.backgroundColor = [UIColor TKcolorWithHexString:TK_Color_black_main_1];

    eventResponseAreaView.backgroundColor = [UIColor clearColor];
    [self addSubview:eventResponseAreaView];
    
    [self addButnView:showContentView];
    [contentView addSubview:showContentView];
    [self addSubview:contentView];
    
    return self;
}


-(void)addButnView:(UIView * )view{
    
    CGFloat width = DefaultMenuWidth/self.btns.count;
    

    for(int i =0;i<self.btns.count;i++){
    
        UIButton * btn = self.btns[i];
        
//        btn.backgroundColor = [UIColor redColor];
        
        
        btn.tag = 100 +i;
        
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i*width);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(DefaultMenuHeight);
            
            
//            make.center.mas_equalTo(CGPointMake(width*(i+0.5), DefaultMenuHeight/2));
//            make.size.mas_equalTo(CGPointMake(width, DefaultMenuHeight));

        }];
        
        [btn updateConstraints];
        
        
    }
    
}

-(void)onBtnClick:(UIButton *)btn{
    
    NSInteger index =   btn.tag - 100;
    DDLogInfo(@"pop menu btn click at index = %ld",index);
    
    [self hiddenMenu:YES];
    if(_delegate){
    
        [_delegate menuDidSelectIndex :index withTempData:_tempdata];
    }

}


-(NSArray *)btns{

    if(!_btns){
        
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn1 setTitle:@"1" forState:UIControlStateNormal];
        
        UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn2 setTitle:@"2" forState:UIControlStateNormal];
    
        _btns = [[NSArray alloc] initWithObjects:btn1,btn2,nil];
        
    }
    
    return _btns;
}



- (instancetype)initWithCategorys:(NSMutableArray *)categorys
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    currentSelect = 0;
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        titlesArray = [categorys copy];
        UIButton *hiddenBtn = [[UIButton alloc]initWithFrame:self.frame];
        [hiddenBtn addTarget:self action:@selector(hiddenAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hiddenBtn];
        CGFloat o_x = CGRectGetWidth(self.frame)-DefaultMenuWidth - 6;
        menuRect = CGRectMake(o_x, 74, DefaultMenuWidth, self.mMenuHeight*categorys.count);
    }
    return self;
}

- (void)hiddenAction
{
    [self hiddenMenu:YES];
}

- (void)showMenu:(CGPoint)Point
{
    UIViewController *rootVC = [[[UIApplication sharedApplication]keyWindow]rootViewController];
    [rootVC.view addSubview:self];
    centerX = Point.x - DefaultMenuWidth/2;
    centerY = Point.y + DefaultMenuHeight/2;
    contentView.center = CGPointMake(centerX,centerY);
    eventResponseAreaView.center = contentView.center;
    isShow = true;
    showContentView.center = CGPointMake(DefaultMenuWidth*3/2,DefaultMenuHeight/2);
    [UIView animateWithDuration:0.3f animations:^{
        showContentView.center = CGPointMake(DefaultMenuWidth/2,DefaultMenuHeight/2);
    } completion:^(BOOL finished) {
    }];
}


- (void)hidWithAnima:(BOOL)ani{

    [self hiddenMenu:ani];
}


- (void)hiddenMenu:(BOOL)animated
{
    isShow = false;
    if (animated) {
        WS(weakSelf)
        showContentView.center = CGPointMake(DefaultMenuWidth,DefaultMenuHeight/2);
        [UIView animateWithDuration:0.3f animations:^{
            showContentView.center = CGPointMake(DefaultMenuWidth*3/2,DefaultMenuHeight/2);
        } completion:^(BOOL finished) {
            if (finished) {
                if(!isShow){
                    [weakSelf removeFromSuperview];
                }
            }
        }];
    }else{
        if(!isShow){
            [self removeFromSuperview];
        }
        
    }
}

- (CGFloat)mMenuHeight
{
    CGFloat height = DefaultMenuHeight;
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForCell)]) {
        height = [self.delegate heightForCell];
    }
    return height;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   [super hitTest:point withEvent:event];
    CGPoint activePoint = [contentView convertPoint:point fromView:self];
    CGPoint dismissPoint = [eventResponseAreaView convertPoint:point fromView:self];
    if ([contentView pointInside:activePoint withEvent:event]) {
        UIView * clickView = [super hitTest:point withEvent:event];
        return clickView;
    }else if ([eventResponseAreaView pointInside:dismissPoint withEvent:event]) {
    
        [self hiddenMenu:YES];
        return eventResponseAreaView;
    }else{
        [self hiddenMenu:NO];
        return nil;
    }
}

@end
