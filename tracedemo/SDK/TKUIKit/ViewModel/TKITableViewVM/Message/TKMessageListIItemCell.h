//
//  TKMessageListIItemCell.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/18.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TKMessageType) {
    TKMessageTypeForgive = 0,//弃单
    TKMessageTypeStatement,//结算通知
    TKMessageTypePraise,//点赞提醒
    TKMessageTypeService,//客服消息
    TKMessageTypeDefault,//默认
};

@interface TKMessageData : NSObject
@property (nonatomic, assign) TKMessageType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *describle;
@property (nonatomic, assign) NSUInteger secondsUTC;
@end

@interface TKMessageListIItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *headImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;

- (void)setContentData:(TKMessageData *)data;

@end


