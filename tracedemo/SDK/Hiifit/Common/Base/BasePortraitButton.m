//
//  PortraitButton.m
//  GuanHealth
//
//  Created by hermit on 15/5/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BasePortraitButton.h"

@implementation BasePortraitButton
- (instancetype)init
{
    self = [super init];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    [self.layer setCornerRadius:self.frame.size.height/2];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    [self.layer setCornerRadius:self.frame.size.height/2];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    [self.layer setCornerRadius:self.frame.size.height/2];
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    [self.layer setCornerRadius:frame.size.height/2];
}
@end
