//
//  HFEditHeaderView.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/26.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFEditHeaderView.h"

@implementation HFEditHeaderView

- (void)awakeFromNib {
    // Initialization code
    self.headerImage.layer.cornerRadius = self.headerImage.frame.size.height / 2;
    self.headerImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)selectPicture:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(choosePicture)]) {
        [self.delegate choosePicture];
    }
}

- (IBAction)chooseBoyBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseBoy)]) {
        [self.delegate chooseBoy];
    }
}

- (IBAction)chooseGirlBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseGirl)]) {
        [self.delegate chooseGirl];
    }
}
- (void)changeUserSex:(BOOL)boy
{
    if (boy) {
        [self.boyBtn setBackgroundImage:IMG(@"My_roundBottom") forState:UIControlStateNormal];
        [self.boyBtn setTitleColor:[UIColor hexChangeFloat:@"FFFFFF"] forState:UIControlStateNormal];
        [self.girlBtn setBackgroundImage:IMG(@"My_roundBottomWhite") forState:UIControlStateNormal];
        [self.girlBtn setTitleColor:[UIColor hexChangeFloat:@"999999"] forState:UIControlStateNormal];
    }else{
        [self.girlBtn setBackgroundImage:IMG(@"My_roundBottom") forState:UIControlStateNormal];
        [self.girlBtn setTitleColor:[UIColor hexChangeFloat:@"FFFFFF"] forState:UIControlStateNormal];
        [self.boyBtn setBackgroundImage:IMG(@"My_roundBottomWhite") forState:UIControlStateNormal];
        [self.boyBtn setTitleColor:[UIColor hexChangeFloat:@"999999"] forState:UIControlStateNormal];
    }
}
@end
