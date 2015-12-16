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

static CGFloat DefaultMenuWidth = 180;
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
@property (strong, nonatomic) NSArray * defaultBtns;

@end

@implementation TK_menuViewVC


-(instancetype)init{

    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    [self initDefaultViews];
    [self addButnView:showContentView withButtons:self.defaultBtns];
    return self;
}


-(void)initDefaultViews{

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
    [contentView addSubview:showContentView];
    [self addSubview:contentView];

}


-(instancetype)initWithButtons:(NSArray *)buts
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    [self initDefaultViews];
    [self addButnView:showContentView withButtons:buts];
    return self;
}



-(void)addButnView:(UIView * )view withButtons:(NSArray *)btns
{
    
    CGFloat width = DefaultMenuWidth/btns.count;
    
    
    for(int i =0;i< btns.count;i++)
    {
        
        UIButton * btn = btns[i];
        
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
        // 增加分割线
        if(i != 0)
        {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(width * i, DefaultMenuHeight/4, 1, DefaultMenuHeight/2)];
            label.backgroundColor = [UIColor TKcolorWithHexString:TK_Color_white_main];
            [view addSubview:label];
        }
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


-(NSArray *)defaultBtns{

    if(!_defaultBtns){
        
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn1 setTitle:@"1" forState:UIControlStateNormal];
        
        UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn2 setTitle:@"2" forState:UIControlStateNormal];
    
        _defaultBtns = [[NSArray alloc] initWithObjects:btn1,btn2,nil];
        
    }
    
    return _defaultBtns;
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


- (void)showMenu:(CGPoint)point withButtons:(NSArray *)btns withTempData:(NSObject *)tempData{

    
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


+(void)setDefaultBtnStyle:(UIButton *)btn
{
    UIImage * defaultImage = [UIColor TKcreateImageWithColor:[UIColor TKcolorWithHexString:TK_Color_black_main]];
    UIImage * activeImage = [UIColor TKcreateImageWithColor:[UIColor TKcolorWithHexString:TK_Color_nav_textActive]];
    [btn setBackgroundImage:defaultImage forState:UIControlStateNormal];
    [btn setBackgroundImage:activeImage forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor TKcolorWithHexString:TK_Color_white_main] forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor TKcolorWithHexString:TK_Color_Wite] forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, -5)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -1.0, 0.0, 0.0)];
}

@end
