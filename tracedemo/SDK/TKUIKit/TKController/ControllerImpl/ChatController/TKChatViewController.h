//
//  DemoVC11.h
//  SDAutoLayoutDemo
//
//  Created by gsd on 16/2/17.
//  Copyright © 2016年 gsd. All rights reserved.
//


/*
 
 *********************************************************************************
 *                                                                                *
 * 在您使用此自动布局库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并  *
 * 帮您解决问题。                                                                    *
 * 持续更新地址: https://github.com/gsdios/SDAutoLayout                              *
 * Email : gsdios@126.com                                                          *
 * GitHub: https://github.com/gsdios                                               *
 * 新浪微博:GSD_iOS                                                                 *
 * QQ交流群：519489682（已满）497140713                                              *
 *********************************************************************************
 
 */



#import "TKIBaseNavWithDefaultBackVC.h"

@interface TKChatViewController :TKIBaseNavWithDefaultBackVC
//@property (nonatomic,assign)
@property (nonatomic,strong)NSString * toId;
@property (nonatomic,strong)NSString * toUserRole;
@property (nonatomic,strong)NSString * toUserPicUrl;



/**
 显示聊天窗口
 **/
+(void)showChatView:(NSString *)toId toUserRole:(NSString *)toUserRole;


@end
