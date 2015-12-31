//
//  TKTableSectionM.h
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTableViewRowM.h"

@interface TKTableSectionM : NSObject

@property (nonatomic,copy) NSString * sectionTitle;
/**
 *  section head 高度， 默认是 10
 */
@property (nonatomic,assign)CGFloat sectionHeadHeight;
/**
 *  section foot 高度，默认是 0
 */
@property (nonatomic,assign)CGFloat sectionFootHeight;

/**
 *  section  cell高度，默认是 44, 如果设置了 TKTableViewRowM 的 rowHeight  则row的设置生效
 */
@property (nonatomic,assign)CGFloat rowHeight;

@property (nonatomic,strong)NSMutableArray<__kindof TKTableViewRowM *> * rowsData;


@property (nonatomic,strong)UIView * tkFootView;

@property (nonatomic,strong)UIView * tkHeadView;

-(void)initDefaultRowData:(NSInteger)count;

@end
