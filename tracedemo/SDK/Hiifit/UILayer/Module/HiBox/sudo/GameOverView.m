//
//  GameOverView.m
//  GuanHealth
//
//  Created by hermit on 15/5/12.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "GameOverView.h"

@implementation GameOverView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setContent:(UploadGameRes*)res;
{
    self.shareBtn.highlighted = NO;
    _rankLabel.text = [NSString stringWithFormat:@"%i",res.rankInIdol];
    _timeLabel.text = [UIKitTool getTimeStrFromUTC:res.spendTime];
    if (res.data.count == 0) {
        self.firstView.hidden = YES;
        self.secondView.hidden = YES;
        self.thirdView.hidden = YES;
        return;
    }else if (res.data.count == 1){
        self.secondView.hidden = YES;
        self.thirdView.hidden = YES;
        //dispatch_async(dispatch_get_main_queue(), ^{
            self.firstView.center = self.secondView.center;
        //});
        UploadGameData *data = [res.data firstObject];
        [self.firstHeadImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.firstTimeLabel.text = [UIKitTool getTimeStrFromUTC:data.spendTime];
    }else if (res.data.count == 2){
        self.thirdView.hidden = YES;
        UploadGameData *data1 = [res.data firstObject];
        [self.firstHeadImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data1.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.firstTimeLabel.text = [UIKitTool getTimeStrFromUTC:data1.spendTime];
        
        UploadGameData *data2 = [res.data lastObject];
        [self.secondHeadImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data2.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.secondTimeLabel.text = [UIKitTool getTimeStrFromUTC:data2.spendTime];
        
        //dispatch_async(dispatch_get_main_queue(), ^{
            self.firstView.center = CGPointMake(self.firstView.center.x + self.firstView.frame.size.width/2, self.firstView.center.y);
            
            self.secondView.center = CGPointMake(self.secondView.center.x - self.secondView.frame.size.width/2, self.secondView.center.y);
        //});
    }else if (res.data.count == 3){
        UploadGameData *data1 = [res.data firstObject];
        [self.firstHeadImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data1.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.firstTimeLabel.text = [UIKitTool getTimeStrFromUTC:data1.spendTime];
        
        UploadGameData *data2 = [res.data objectAtIndex:1];
        [self.secondHeadImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data2.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.secondTimeLabel.text = [UIKitTool getTimeStrFromUTC:data2.spendTime];
        
        UploadGameData *data3 = [res.data lastObject];
        [self.thirdHeadImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data3.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.thirdTimeLabel.text = [UIKitTool getTimeStrFromUTC:data3.spendTime];
    }
}



@end
