//
//  HFEditInfoCell.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/26.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFEditInfoCellDelegate <NSObject>


@end
@interface HFEditInfoCell : BaseTableCell

@property (nonatomic, weak) id<HFEditInfoCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *signLabel;


@end
