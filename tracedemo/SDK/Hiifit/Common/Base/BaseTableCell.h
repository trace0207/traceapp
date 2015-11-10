//
//  BaseTableCell.h
//  rentCar
//
//  Created by duonuo on 14-6-26.
//  Copyright (c) 2014年 duonuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableCell : UITableViewCell

@property (nonatomic, assign) NSInteger cellIndex;


- (id)initWithXibName:(NSString*)strName;
- (id)initWithIndex:(NSInteger)index;
- (CGFloat)calculateHeight;

@end
