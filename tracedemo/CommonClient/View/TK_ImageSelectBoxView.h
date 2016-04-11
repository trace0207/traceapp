//
//  TK_ImageSelectBoxView.h
//  tracedemo
//
//  Created by cmcc on 16/3/10.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TK_ImageSelectBoxView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIView *goodsDesLayer;
@property (weak, nonatomic) IBOutlet UIView *addIconLayer;

@property (weak, nonatomic) IBOutlet UILabel *bottomDescText;
@property (weak, nonatomic) IBOutlet UILabel *centerDescText;
@property (weak, nonatomic) IBOutlet UIImageView *smallAddIcon;
@property (weak, nonatomic) IBOutlet UIImageView *bigAddIcon;
@property (nonatomic,strong) NSString * remoutURL;

typedef NS_ENUM(NSInteger,ImageBoxStatus)
{
    ImageStatus = 1,
    NormalAddBtn = 2,
    DescAddBtn = 3,
    NormalImage = 4
    
};


-(void)setStatus:(ImageBoxStatus)status;


-(void)setURL:(NSString *)url withStatus:(ImageBoxStatus)status;

@end
