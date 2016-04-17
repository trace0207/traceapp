//
//  NotifyMsgTableCell.h
//  tracedemo
//
//  Created by cmcc on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifyMsgTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
