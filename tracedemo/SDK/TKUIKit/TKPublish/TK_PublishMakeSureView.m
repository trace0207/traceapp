//
//  TK_PublishMakeSureView.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/1.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_PublishMakeSureView.h"

@implementation TK_PublishMakeSureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    self = [super init];
    self.frame = [UIScreen mainScreen].bounds;
     _errorImage.hidden = YES;
    _loading.hidden = NO;
    [_loading startAnimating];
    _loadingTips.text = @"正在上传图片...";
    [self performSelector:@selector(showLoadingError) withObject:nil afterDelay:3.0f];
    return self;
}


-(void)showLoadingError{

    _errorImage.hidden = NO;
    [_loading stopAnimating];
    _loading.hidden = YES;
    _loadingTips.text = @"发布悬赏失败，请重试";
    
}


- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
}
@end
