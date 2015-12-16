//
//  TKIShowGoodsRowM.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/15.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKTableViewRowM.h"



@interface TKShowGoodsRowData : NSObject

@property (nonatomic,strong)NSMutableArray * pics;

@end

@interface TKIShowGoodsRowM : TKTableViewRowM
@property (nonatomic,strong) TKShowGoodsRowData * showGoodsData;

-(CGFloat)getPicWidth;
-(CGFloat)getPicSeparation;
-(CGFloat)getPicHeight;
-(CGFloat)getPicPaddingLeft;
@end
