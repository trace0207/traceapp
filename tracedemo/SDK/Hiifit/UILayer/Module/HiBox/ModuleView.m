//
//  ModuleView.m
//  GuanHealth
//
//  Created by hermit on 15/4/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ModuleView.h"

@implementation ModuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setBorderWidth:0.5f];
        [self.layer setCornerRadius:0.2f];
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        _moduleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [self addSubview:_moduleImageView];
        
        _moduleNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.width, frame.size.width, frame.size.height - frame.size.width)];
        _moduleNameLabel.textColor = [UIColor hexChangeFloat:@"3f3f3f" withAlpha:1];
        _moduleNameLabel.font = [UIFont systemFontOfSize:12.0f];
        _moduleNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_moduleNameLabel];
        
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_detailBtn];
        
        UIImage *highlitImage = [UIImage imageNamed:@"button_add"];
        UIImage *nomalImage = [UIImage imageNamed:@"button_off"];
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.frame = CGRectMake(frame.size.width-30, 0, 30, 30);
        [self.addBtn setBackgroundImage:nomalImage forState:UIControlStateSelected];
        [self.addBtn setBackgroundImage:highlitImage forState:UIControlStateNormal];
        
        [self addSubview:self.addBtn];
    }
    return self;
}

- (void)setValue:(HiModuleListData*)module
{
    self.addBtn.tag = module.id;
    self.detailBtn.tag = module.id;
    [_moduleImageView sd_setImageWithURL:[NSURL URLWithString:module.backgroundAddr] placeholderImage:[UIImage imageNamed:@"img_default"]];
    [_moduleNameLabel setText:module.modelName];
    if (module.flag == 1) {
        self.addBtn.selected = YES;
    }else{
        self.addBtn.selected = NO;
    }
}

@end
