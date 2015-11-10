//
//  HFIntroduceCell.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/10.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFIntroduceCell.h"

@interface HFIntroduceCell()

@property (weak, nonatomic) IBOutlet UILabel *badLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodLabel;

@end
@implementation HFIntroduceCell

- (void)awakeFromNib {
    // Initialization code
    //        textHeight = [UIKitTool heightForCell:post.content withFont:15.0f withWidth:kScreenWidth - o_x - 10];
    self.badLabel.text = @"久坐不起，缺乏运动是加剧颈椎问题的推手，颈椎长时间处于屈位或某些特定体位，是颈椎间盘内压力增高，引起颈椎不适。建议定期进行活动，有氧运动可以令气血通畅，无氧运动可令肌肉结实（辅助骨骼支撑）";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]};

    CGFloat badLabelHeight = [UIKitTool caculateHeight:self.badLabel.text sizeOfWidth:kScreenWidth - 54 - 10 withAttributes:attributes];
    self.badLabel.frame = CGRectMake(self.badLabel.frame.origin.x, self.badLabel.frame.origin.y, self.badLabel.frame.size.width, badLabelHeight);
    NSLog(@"%f", badLabelHeight);
    self.badLabel.numberOfLines = 0;
    
    
    self.goodLabel.text = @"缺乏钙导致骨质增生，缺乏蛋白质会导致骨骼修复缓慢，缺乏维生素会导致颈椎以及周边韧带退行性变，刺激，压迫神经根，从而导致颈椎病，建议改善饮食，多吃：牛奶，豆制品，海鲜等含钙，蛋白质食物，定期补充维生素B，C";
    self.goodLabel.numberOfLines = 0;
    CGFloat goodLabelTextHeight = [UIKitTool caculateHeight:self.goodLabel.text sizeOfWidth:kScreenWidth - 54 - 10 withAttributes:attributes];
    NSLog(@"%f", goodLabelTextHeight);
    self.goodLabel.frame = CGRectMake(self.goodLabel.frame.origin.x, self.goodLabel.frame.origin.y, self.goodLabel.frame.size.width, goodLabelTextHeight);
    self.userInteractionEnabled = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
