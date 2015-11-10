//
//  HFQuestionTestViewController.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/25.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BaseViewController.h"

@protocol HFQuestionTestDelegate <NSObject>

@optional
- (void)schemeStart;
//- (void)schemeCancle;

@end

@interface HFQuestionTestViewController : BaseViewController

- (id)initFromMainAdvancePage:(BOOL)bFrom;
@property (nonatomic, weak) id<HFQuestionTestDelegate>delegate;
@property (nonatomic, assign) NSInteger schemeId;

@end
