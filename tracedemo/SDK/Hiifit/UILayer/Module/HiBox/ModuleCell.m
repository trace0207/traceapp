//
//  ModuleCell.m
//  GuanHealth
//
//  Created by hermit on 15/4/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ModuleCell.h"

@implementation ModuleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1];
        _view1 = [[ModuleView alloc]initWithFrame:CGRectMake(5, 5, kModuleWidth, kModuleHeight)];
        _view2 = [[ModuleView alloc]initWithFrame:CGRectMake(10+kModuleWidth, 5, kModuleWidth, kModuleHeight)];
        _view3 = [[ModuleView alloc]initWithFrame:CGRectMake(15+kModuleWidth*2, 5, kModuleWidth, kModuleHeight)];
        [self addSubview:_view1];
        [self addSubview:_view2];
        [self addSubview:_view3];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [_view1.addBtn addTarget:self action:@selector(addOrDeleteModuleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_view2.addBtn addTarget:self action:@selector(addOrDeleteModuleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_view3.addBtn addTarget:self action:@selector(addOrDeleteModuleAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_view1.detailBtn addTarget:self action:@selector(moduleDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        [_view2.detailBtn addTarget:self action:@selector(moduleDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        [_view3.detailBtn addTarget:self action:@selector(moduleDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setValuefirstMod:(HiModuleListData*)module1
            andSecondMod:(HiModuleListData*)module2
             andThirdMod:(HiModuleListData*)module3
{
    if (module1) {
        [_view1 setValue:module1];
    }
    if (module2) {
        _view2.hidden = NO;
        [_view2 setValue:module2];
    }else{
        _view2.hidden = YES;
    }
    if (module3) {
        _view3.hidden = NO;
        [_view3 setValue:module3];
    }else{
        _view3.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)addOrDeleteModuleAction:(UIButton*)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(addOrDeleteModuleModuleId:isDelete:)]) {
        [_delegate addOrDeleteModuleModuleId:btn.tag isDelete:btn.selected];
        btn.selected = !btn.selected;
    }
}

- (void)moduleDetailAction:(UIButton*)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(seeModuleDetailModuleId:)]) {
        [_delegate seeModuleDetailModuleId:btn.tag];
    }
}

@end
