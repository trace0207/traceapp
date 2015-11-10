//
//  BaseView.m
//  GuanHealth
//
//  Created by hermit on 15/2/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)init{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    self = [nibs objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

- (id)initWithXibName:(NSString*)strName{
    NSString *strNib = strName? strName : NSStringFromClass([self class]);
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:strNib owner:self options:nil];
    self = [nibs objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

- (id)initWithIndex:(NSInteger)index{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    self = [nibs objectAtIndex:index];
    if (self) {
        
    }
    return self;
}

@end
