//
//  TK_ImageSelectBoxView.m
//  tracedemo
//
//  Created by cmcc on 16/3/10.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TK_ImageSelectBoxView.h"
#import "Masonry.h"


@interface TK_ImageSelectBoxView()

@end
@implementation TK_ImageSelectBoxView




-(instancetype)init
{
    self  = [super init];
    UIView * view = [[NSBundle mainBundle] loadNibNamed:@"TK_ImageSelectBoxView" owner:self options:nil].lastObject;
    [self addSubview:view];
    //    self.frame = CGRectMake(0, 0, 100, 100);
    self.clipsToBounds = YES;
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];

    return self;
}


-(void)awakeFromNib
{
    
    DDLogInfo(@"imageSelectBoxView awakeFromNib");
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
 
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UIView * view = [[NSBundle mainBundle] loadNibNamed:@"TK_ImageSelectBoxView" owner:self options:nil].lastObject;
    [self addSubview:view];
//    self.frame = CGRectMake(0, 0, 100, 100);
    self.clipsToBounds = YES;
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
    
    return self;
}


-(void)setStatus:(ImageBoxStatus)status
{
    if(status == ImageStatus)
    {
        self.mainImage.hidden = NO;
        self.addIconLayer.hidden = YES;
        self.goodsDesLayer.hidden = NO;
    }
    else if(status == NormalAddBtn)
    {
        self.addIconLayer.hidden = NO;
        self.bigAddIcon.hidden = NO;
        self.smallAddIcon.hidden = YES;
        self.centerDescText.hidden = YES;
        self.mainImage.hidden = YES;
        self.goodsDesLayer.hidden = YES;
    }else if(status == NormalImage)
    {
        self.goodsDesLayer.hidden = YES;
        self.mainImage.hidden = NO;
        self.addIconLayer.hidden = YES;
    }else if(status == DescAddBtn)
    {
        self.addIconLayer.hidden = NO;
        self.bigAddIcon.hidden = YES;
        self.smallAddIcon.hidden = NO;
        self.centerDescText.hidden = NO;
        self.mainImage.hidden = YES;
        self.goodsDesLayer.hidden = YES;
    }
}

-(void)setURL:(NSString *)url withStatus:(ImageBoxStatus)status
{
    _remoutURL = url;
    TKSetLoadingImageView(self.mainImage, _remoutURL);
    [self setStatus:status];
    
}

@end
