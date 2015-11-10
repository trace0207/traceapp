//
//  ChildSchemeViewController.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BaseViewController.h"
@protocol ChildSchemeDeleagte <NSObject>

- (void)giveUpSubScheme:(BOOL)lastSubScheme;

@end

@interface ChildSchemeViewController : BaseViewController

@property (nonatomic, weak) id<ChildSchemeDeleagte>delegate;
@property (nonatomic, copy) NSString *subSchemeName;
@property (nonatomic, assign) NSInteger subSchemeId;
@property (nonatomic, assign) NSInteger schemeId;
@property (nonatomic, assign) NSInteger tiebaId;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger   subscribeSize;

@end
