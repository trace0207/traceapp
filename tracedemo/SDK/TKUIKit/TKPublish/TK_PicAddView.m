//
//  TK_PicAddView.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_PicAddView.h"

@interface TK_PicAddView()
{
    
    UIButton * addBtn;
    
    NSArray * picArray ;
    
    CGFloat  newHeight;
    
}

@end

@implementation TK_PicAddView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initDefaultAddWithFrame:(CGRect)frame{
    
    self = [self initDefaultAdd];
    self.frame = frame;
    return self;
}


-(instancetype)initDefaultAdd{
    self = [super init];
    [self tkRemoveAllChildView];
    self.frame = CGRectMake(0, 0, kScreenWidth, self.picHeight);
    [self tkAddBtnWithFrame:CGRectMake(self.paddingLeft, self.paddingTop, self.picWidth, self.picHeight)];
    self.backgroundColor = [UIColor clearColor];
    return self;
}


-(void)tkReloadWithDefaultPic:(NSArray *)pics
{
    picArray = pics;
    [self tkRemoveAllChildView];
    [self setPicturesToCell:picArray];
    
    
}

-(void)reload{

    [self tkRemoveAllChildView];
    [self setPicturesToCell:picArray];
}


-(CGFloat)tkGetViewsHeight
{
    
    return newHeight;
}

-(void)tkAddBtnWithFrame:(CGRect)frame
{
    
    [self getAddBtn].frame = frame;
    [[self getAddBtn] setBackgroundImage:[UIImage imageNamed:self.defaultAddPicStr] forState:UIControlStateNormal];
    [self addSubview:[self getAddBtn]];
}




-(void)tkRemoveAllChildView
{
    NSArray  * array =   [self subviews];
    for(UIView *v in array)
    {
        [v removeFromSuperview];
    }
}



- (void)setPicturesToCell:(NSArray *)pictures
{
    newHeight = 0;
    for (int i=0; (i<pictures.count && i< self.maxCount); i++) {
        UIImage *tempImg = [pictures objectAtIndex:i];
        CGRect picFrameForI = CGRectMake(self.paddingLeft + (i%4)*(self.picWidth + self.paddingLeft),
                                         (i/4)*(self.picHeight + self.paddingTop)+ self.paddingTop, self.picWidth, self.picHeight);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:picFrameForI];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = tempImg;
        imageView.tag = i+100;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tkPicViewSelect:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
    if(pictures.count < self.maxCount)
    {
        int index = pictures.count;
        CGRect picFrameForAdd= CGRectMake(self.paddingLeft + (index%4)*(self.picWidth + self.paddingLeft),
                                          (index/4)*(self.picHeight + self.paddingTop) + self.paddingTop, self.picWidth, self.picHeight);
        [self tkAddBtnWithFrame:picFrameForAdd];
    }
    newHeight += (pictures.count/4 +1)*(self.picHeight + self.paddingTop);
    newHeight += self.paddingTop; // 加底部边距  和 top一样
}


-(void)tkAddAction
{
    if(self.tkAddDelegate)
    {
        [self.tkAddDelegate onAddBtnAction];
    }
    
}

-(void)tkPicViewSelect:(UITapGestureRecognizer*)tap
{
    if(self.tkAddDelegate && [self.tkAddDelegate respondsToSelector:@selector(tkPreviewPicturesAtIndex:)])
    {
        
        NSInteger index = tap.view.tag - 100 + 1;
        [_tkAddDelegate tkPreviewPicturesAtIndex:index];
    }
}



#pragma mark ------ default setting value

-(CGFloat)picWidth{
    
    if(_picWidth == 0)
    {
        _picWidth = (kScreenWidth-5* self.paddingLeft)/4;
    }
    
    return _picWidth;
    
}

-(CGFloat)picHeight
{
    if(_picHeight == 0)
    {
        _picHeight = self.picWidth;
    }
    return _picHeight;
}

-(NSString *)defaultAddPicStr
{
    
    if(_defaultAddPicStr == nil || _defaultAddPicStr.length == 0)
    {
        
        _defaultAddPicStr = @"addPhotos";
        
    }
    
    return _defaultAddPicStr;
}

-(CGFloat)paddingLeft
{
    
    return 10;
}

-(CGFloat)paddingTop
{
    return 10;
}

-(UIButton *)getAddBtn
{
    if(!addBtn)
    {
        addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn addTarget:self action:@selector(tkAddAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return addBtn;
    
}

-(NSInteger)maxCount
{
    if(_maxCount == 0)
    {
        return 10;
    }
    else return _maxCount;
}

@end
