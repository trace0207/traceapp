//
//  TKShowGoodsCell.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/15.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKIShowGoodsRowM.h"
#import "TKHeadImageView.h"


@protocol TKShowGoodsCellDelegate<NSObject>

@required
-(TKShowGoodsRowData *)getRowDataByIndex:(NSIndexPath *) indexPath;

@optional
-(void)onCommentBtnClick:(NSIndexPath *) indexPath;

@end


@interface TKShowGoodsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *imageContentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageFiledHeight;
@property (strong, nonatomic) IBOutlet TKHeadImageView *userHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *contentText;
@property (strong, nonatomic) IBOutlet UILabel *headSecondLabel;
@property (strong, nonatomic) IBOutlet UILabel *headFirstLabel;
@property (strong,nonatomic) NSIndexPath * indexPath;
@property (weak,nonatomic) id<TKShowGoodsCellDelegate> tkShowGoodscellDelegate;


- (IBAction)imageFieldBtn:(id)sender;





- (IBAction)attentionAction:(id)sender;

- (IBAction)commentAction:(id)sender;
- (IBAction)likeAction:(id)sender;
- (IBAction)rewardAction:(id)sender;

@end
