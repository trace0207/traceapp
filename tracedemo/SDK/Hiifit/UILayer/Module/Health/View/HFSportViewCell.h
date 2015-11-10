//
//  HFSportViewCell.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFSportViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *headImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;

- (void)setImage:(NSString *)imageName
           title:(NSString *)title
         content:(NSString *)content;

@end
