//
//  HFCommentLikeView.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCommentLikeView.h"
#import "HFCommentLikeListData.h"

#define Head_View_Tag         1100

@interface HFCommentLikeView()
{
    NSArray * mSources;
}
@property(nonatomic,strong)NSArray * mSources;
@property (nonatomic, strong) UIButton *moreBtn;
@end


@implementation HFCommentLikeView
@synthesize mSources;
@synthesize delegate;
- (id)init
{
    self = [super init];
    if (self) {
        //重新设置self 的frame
        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    UIImageView * starView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 9+7, 15, 14)];
    starView.image = [UIImage imageNamed:@"bad"];
    [self addSubview:starView];
}

- (CGFloat)reloadUI:(NSArray *)sourceArr
{
    if (sourceArr.count == 0) {
        return 0.0f;
    }
    //如果存在则去掉原来的
    //CGFloat height = 0.0;
    CGFloat orignX = 25+16;
    CGFloat orignY = 7;
    
    //删除原来的视图
    for (id view in self.subviews) {
        if ([view isKindOfClass:[BasePortraitView class]]) {
            [view removeFromSuperview];
        }
    }
    
    self.mSources = sourceArr;
    
    NSInteger  maxLineNum;
    CGFloat space;
    if (kScreenWidth > 375)
    {
        maxLineNum = 8;
        
        space = 10.0;
    }
    else if (kScreenWidth > 320)
    {
        maxLineNum = 7;
        
        space = 10.0;
    }
    else
    {
        maxLineNum = 6;
        
        space = 10.0;
    }
    NSInteger lineNum = MIN(mSources.count, maxLineNum);
//    if (mSources.count > maxLineNum) {
//        self.moreBtn.hidden = NO;
//        lineNum = maxLineNum - 1;
//    }else {
//        if (_moreBtn) {
//            _moreBtn.hidden = YES;
//        }
//    }
    self.moreBtn.hidden = NO;
    for (int i = 0; i < lineNum; i++) {
        HFCommentLikeListData * data = [mSources objectAtIndex:i];
        
        BasePortraitView * imageView = [[BasePortraitView alloc] initWithFrame:CGRectMake(orignX + i % maxLineNum * (30 + space), orignY + i / maxLineNum * (30 + space), 30, 30)];
        imageView.tag = Head_View_Tag + i;
        [imageView addAction:@selector(headImageViewAction:) forTarget:self];
        if (!data.headPortraitUrl)
        {
            imageView.image = [UIImage imageNamed:@"head_default"];
        }
        else
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        }
        
        [self addSubview:imageView];
    }
    return 44;
}

- (void)headImageViewAction:(UITapGestureRecognizer *)tap
{
    BasePortraitView * imageView = (BasePortraitView *)[tap view];
    NSInteger index = imageView.tag - Head_View_Tag;
    HFCommentLikeListData * data = [mSources objectAtIndex:index];
    if (delegate && [delegate respondsToSelector:@selector(liveViewHeadAction:)])
    {
        [delegate liveViewHeadAction:data.userId];
    }
}

-(UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 38, 0, 38, 44)];
        [_moreBtn setImage:IMG(@"new_arrow") forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreBtn];
    }
    return _moreBtn;
}

- (void)moreAction:(UIButton *)btn
{
    if (delegate && [delegate respondsToSelector:@selector(moreUserLikes:)])
    {
        [delegate moreUserLikes:mSources];
    }
}

@end
