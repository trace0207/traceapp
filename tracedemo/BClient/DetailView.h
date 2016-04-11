//
//  DetailView.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BaseView.h"
#import "CountDownView.h"
#import "TKHeadImageView.h"
@interface DetailView : BaseView
@property (weak, nonatomic) IBOutlet TKHeadImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet CountDownView *countDownView;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;



@end
