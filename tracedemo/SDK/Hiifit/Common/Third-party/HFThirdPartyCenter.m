//
//  HFThirdPartyCenter.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFThirdPartyCenter.h"
#import "Masonry.h"
#import "MobClick.h"
#import <ShareSDK/ShareSDK.h>

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import "WeiboSDK.h"
#import "WXApi.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "UIKitTool.h"

@interface HFThirdPartyCenter()

@property (nonatomic, strong) NSMutableArray * contentArray;
@property (nonatomic, strong) NSMutableArray * itemDic;

@end

@implementation HFThirdPartyCenter

static id _publishContent;

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HFThirdPartyCenter, shareInstance)

- (void)startInit
{
    //初始化友盟
    [self startUMeng];
    //初始化ShareSDK
    [self startShareSDK];
}


- (BOOL)QQInstall
{
    return [QQApi isQQInstalled];
}

- (BOOL)WXInstall
{
    return [WXApi isWXAppInstalled];
}


- (void)startUMeng
{
    [MobClick startWithAppkey:@"5577a36167e58e89fd0046ae"];
    [MobClick setLogEnabled:YES];
    [MobClick setAppVersion:XcodeAppVersion];
}

- (void)startShareSDK
{
#if APP_STORE ==1
    [ShareSDK registerApp:@"8204d310e7d9"];
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"2972294865"
                                appSecret:@"ebea81e9663805436f33197444aa39b7"
                              redirectUri:@"http://open.weibo.com/apps/2972294865/info/advanced"
                              weiboSDKCls:[WeiboSDK class]];
    
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithAppId:@"1104779069"
                        qqApiCls:[QQApi class]];
    
    //QQ本身没有授权功能，所以想要使用QQ做第三方登录必须通过QQ空间来实现！
    [ShareSDK connectQZoneWithAppKey:@"1104779069"
                           appSecret:@"Ey9vNpqabbA5bBk2"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx74780fbe2cbccc09"
                           appSecret:@"515b232b0b75baa6d1a44fed176ce4d0"
                           wechatCls:[WXApi class]];
#else
    [ShareSDK registerApp:@"8204d310e7d9"];
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"2972294865"
                                appSecret:@"ebea81e9663805436f33197444aa39b7"
                              redirectUri:@"http://open.weibo.com/apps/2972294865/info/advanced"
                              weiboSDKCls:[WeiboSDK class]];
    
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithAppId:@"1104445479"
                        qqApiCls:[QQApi class]];
    
    //QQ本身没有授权功能，所以想要使用QQ做第三方登录必须通过QQ空间来实现！
    [ShareSDK connectQZoneWithAppKey:@"1104445479"
                           appSecret:@"qDIeChuSfafvp4lH"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx063532871f6f9d65"
                           appSecret:@"d5c7d95e78d02cfeaa023a8aa1957a23"
                           wechatCls:[WXApi class]];
#endif
    
    
}

- (void)shareSDKShare:(UIViewController *)controller HiifitType:(NSInteger)type dataDic:(NSDictionary *)dataDic
{
    
    NSString * shareContent = [dataDic objectForKey:@"desc"];
    NSString * title = [dataDic objectForKey:@"title"];
    NSString * pic = [dataDic objectForKey:@"pic"];
    NSString * link = [dataDic objectForKey:@"link"];
    NSString *shareLink = nil;
    if (type == HIModuleTypeScheme) {
        shareLink = kURLShareScheme;
    }else {
        shareLink = kURLShare;
    }
   // WS(weakSelf)
    NSString * hf_Share_Content = [self getShareContent:type];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:hf_Share_Content
                                       defaultContent:hf_Share_Content
                                                image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"]]
                                                title:_T(@"HF_Common_App")
                                                  url:shareLink
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    if (type == HIModuleTypeBanner) {
        publishContent = [ShareSDK content:shareContent defaultContent:shareContent image:[ShareSDK imageWithUrl:pic] title:title url:link description:nil mediaType:SSPublishContentMediaTypeNews];
    }
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPhoneContainerWithViewController:controller];
    
    
    NSString * content = [NSString stringWithFormat:@"%@%@",hf_Share_Content,shareLink];
    if (HIModuleTypeBanner == type) {
        content = [NSString stringWithFormat:@"%@%@", shareContent, link];
    }
    id<ISSContent> weibopublishContent = [ShareSDK content:content
                                            defaultContent:content
                                                     image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"]]
                                                     title:_T(@"HF_Common_App")
                                                       url:shareLink
                                               description:nil
                                                 mediaType:SSPublishContentMediaTypeNews];
    if (HIModuleTypeBanner == type) {
        weibopublishContent = [ShareSDK content:content defaultContent:shareContent image:[ShareSDK imageWithUrl:pic] title:title url:link description:nil mediaType:SSPublishContentMediaTypeNews];
    }
    
    [self checkInstall];
    
    //分享内容
    self.contentArray = [NSMutableArray arrayWithObjects:publishContent, weibopublishContent, nil];
    [self shareWithContent:self.contentArray];

    //自定义sina分享按钮
    //自定义新浪微博分享菜单项
    /*
    id<ISSShareActionSheetItem> sinaItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSinaWeibo]
                                                                              icon:[ShareSDK getClientIconWithType:ShareTypeSinaWeibo]
                                                                      clickHandler:^{
                                                                          [ShareSDK shareContent:weibopublishContent
                                                                                            type:ShareTypeSinaWeibo
                                                                                     authOptions:nil
                                                                                   statusBarTips:YES
                                                                                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                              
                                                                                              if (state == SSPublishContentStateSuccess)
                                                                                              {
                                                                                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                                  [weakSelf showTips:YES error:nil];
                                                                                              }
                                                                                              else if (state == SSPublishContentStateFail)
                                                                                              {
                                                                                    
                                                                                                  NSString * errorinfo = [NSString stringWithFormat:@"分享失败,%@",[error errorDescription]];
                                                                                                  [weakSelf showTips:NO error:errorinfo];
                                                                                              }
                                                                                              
                                                                                          }];
                                                                      }];
    
    
    NSArray *shareList;
    if ([self QQInstall] && [self WXInstall])
    {
        shareList = [ShareSDK customShareListWithType:
                     SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                     sinaItem,
                     SHARE_TYPE_NUMBER(ShareTypeQQ),
                     SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                     //hiiItem,
                     //moreItem,
                     nil];
    }
    else if ([self QQInstall])
    {
        shareList = [ShareSDK customShareListWithType:
                     sinaItem,
                     SHARE_TYPE_NUMBER(ShareTypeQQ),
                     //hiiItem,
                     //moreItem,
                     nil];
    }
    else if ([self WXInstall])
    {
        shareList = [ShareSDK customShareListWithType:
                     SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                     sinaItem,
                     SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                     //hiiItem,
                     //moreItem,
                     nil];
    }
    else
    {
        shareList = [ShareSDK customShareListWithType:
                     sinaItem,
                     //hiiItem,
                     //moreItem,
                     nil];
    }
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
     
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSString * errorinfo = [NSString stringWithFormat:@"分享失败,%@",[error errorDescription]];
                                    [weakSelf showTips:NO error:errorinfo];
                                }
                                
                            }];
     */
}
- (NSString *)getShareContent:(NSInteger)type
{
    switch (type) {
        case HIModuleTypeTestTools:
            return _T(@"HF_ShareTestTools_Content");
            break;
        case HIModuleTypeSelfCheck:
            return _T(@"HF_ShareSelfCheck_Content");
            break;
        case HIModuleTypeHealthNews:
            return _T(@"HF_Share_Content");
            break;
        case HIModuleTypeDrugHelp:
            return _T(@"HF_ShareDrugHelp_Content");
            break;
        case HIModuleTypeCalorie:
            return _T(@"HF_ShareCalorie_Content");
            break;
        case HIModuleTypeDiseaseKnow:
            return _T(@"HF_ShareDiseaseKnow_Content");
            break;
        default:
            break;
    }
    return _T(@"HF_Share_Content");
}
- (void)shareWithContent:(NSArray *)publishContentArray
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;
    blackView.tag = 440;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabBackground:)];
    [blackView addGestureRecognizer:tapGesture];
    [window addSubview:blackView];
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 180)];
    shareView.backgroundColor = [UIColor hexChangeFloat:@"f6f6f6"];
    shareView.tag = 441;
    [window addSubview:shareView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [shareView addSubview:titleLabel];
    titleLabel.text = @"分享到";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15*kScreenScale];
    titleLabel.textColor = [UIColor hexChangeFloat:@"2a2a2a"];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(window.mas_centerX);
        make.top.equalTo(shareView.mas_top).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(60, 21));
    }];
    
    UIView * leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = titleLabel.textColor;
    [shareView addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shareView.mas_left).with.offset(20);
        make.right.equalTo(titleLabel.mas_left);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView * rightLineView = [[UIView alloc] init];
    rightLineView.backgroundColor = leftLineView.backgroundColor;
    [shareView addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right);
        make.right.equalTo(shareView.mas_right).with.offset(-20);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView * buttonView = [[UIView alloc] init];
    [shareView addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shareView.mas_left).with.offset(29);
        make.right.equalTo(shareView.mas_right).with.offset(-29);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(73);
    }];
    
    CGFloat origionX = (kScreenWidth - 58) / 4;
    CGFloat add = (origionX - 42) / (4 - 1);

//    NSArray *btnImages = @[@"share_weixin", @"share_pengyouquan", @"share_qq", @"share_weibo"];
//    NSArray *btnTitles = @[@"微信好友", @"朋友圈", @"QQ好友", @"微博"];
    for (NSInteger i=0; i<self.itemDic.count; i++) {
        NSMutableDictionary * dic = [self.itemDic objectAtIndex:i];
        CGFloat top = 0.0f;
        top = 35;
        NSString * image = [[dic allKeys] firstObject];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(origionX * i + add * i, 0, 42, 42)];
        [button setImage:IMG(image) forState:UIControlStateNormal];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(origionX * i + add * i - 1, 52, 44, 21)];
        titleLabel.text = [[dic allValues] firstObject];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:11.0];
        titleLabel.textColor = leftLineView.backgroundColor;
        [buttonView addSubview:titleLabel];
        
        [button setTitle:[[dic allValues] firstObject] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button];
    }
    
    [UIView animateWithDuration:0.35f animations:^{
        shareView.frame = CGRectMake(0, kScreenHeight - 180, kScreenWidth, 180);
        //blackView.alpha = 0.5;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)shareBtnClick:(UIButton *)btn
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
        blackView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
    }];
    
    int shareType = 0;
    id publishContent = [self.contentArray firstObject];
    if (btn.tag == 334) {
        publishContent = [self.contentArray lastObject];
    }
    NSString * currentTitle = btn.currentTitle;
    if ([currentTitle isEqualToString:@"微信好友"]) {
        shareType = ShareTypeWeixiSession;
    }else if ([currentTitle isEqualToString:@"QQ好友"]){
        shareType = ShareTypeQQ;
    }else if ([currentTitle isEqualToString:@"微博"]){
        shareType = ShareTypeSinaWeibo;
    }else if ([currentTitle isEqualToString:@"朋友圈"]){
        shareType = ShareTypeWeixiTimeline;
    }
    
    /*
     调用shareSDK的无UI分享类型，
     链接地址：http://bbs.mob.com/forum.php?mod=viewthread&tid=110&extra=page%3D1%26filter%3Dtypeid%26typeid%3D34
     */
    WS(weakSelf)
    [ShareSDK showShareViewWithType:shareType container:nil content:publishContent statusBarTips:YES authOptions: nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        if (state == SSResponseStateSuccess) {
            [weakSelf showTips:YES error:nil];
        }else if (state == SSResponseStateFail ){
            NSString * errorinfo = [NSString stringWithFormat:@"分享失败,%@",[error errorDescription]];
            [weakSelf showTips:NO error:errorinfo];
            //            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);

        }
    }];
    
    
    
}
//邀请好友
- (void)shareSDKInviteFriends:(UIViewController *)controller
{
    //WS(weakSelf)
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:_T(@"HF_Share_Content")
                                       defaultContent:_T(@"HF_Share_Content")
                                                image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"]]
                                                title:_T(@"HF_Common_App")
                                                  url:kURLShare
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPhoneContainerWithViewController:controller];
    
    
    NSString * content = [NSString stringWithFormat:@"%@%@",_T(@"HF_Share_Content"),kURLShare];
    id<ISSContent> weibopublishContent = [ShareSDK content:content
                                            defaultContent:content
                                                     image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"]]
                                                     title:_T(@"HF_Common_App")
                                                       url:kURLShare
                                               description:nil
                                                 mediaType:SSPublishContentMediaTypeNews];
    [self checkInstall];
    
    NSMutableArray * array = [NSMutableArray arrayWithObjects:publishContent, weibopublishContent, nil];
    [self shareWithContent:[NSArray arrayWithArray:array]];
    
    //自定义sina分享按钮
    //自定义新浪微博分享菜单项
    /*
    id<ISSShareActionSheetItem> sinaItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSinaWeibo]
                                                                              icon:[ShareSDK getClientIconWithType:ShareTypeSinaWeibo]
                                                                      clickHandler:^{
                                                                          [ShareSDK shareContent:weibopublishContent
                                                                                            type:ShareTypeSinaWeibo
                                                                                     authOptions:nil
                                                                                   statusBarTips:YES
                                                                                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                              
                                                                                              if (state == SSPublishContentStateSuccess)
                                                                                              {
                                                                                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                                  [weakSelf showTips:YES error:nil];
                                                                                              }
                                                                                              else if (state == SSPublishContentStateFail)
                                                                                              {
                                                                                                  
                                                                                                  NSString * errorinfo = [NSString stringWithFormat:@"分享失败,%@",[error errorDescription]];
                                                                                                  [weakSelf showTips:NO error:errorinfo];
                                                                                              }
                                                                                              
                                                                                          }];
                                                                      }];
    

    
    NSArray *shareList = [ShareSDK customShareListWithType:
                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                          SHARE_TYPE_NUMBER(ShareTypeQQ),
                          sinaItem,
                          nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                    [weakSelf showTips:YES error:nil];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSString * errorinfo = [NSString stringWithFormat:@"分享失败,%@",[error errorDescription]];
                                    [weakSelf showTips:NO error:errorinfo];
                                }
                                
                            }];
     */
}

- (void)showTips:(BOOL)success error:(NSString *)errorInfo
{
    if (success)
    {
        [MBProgressHUD showSuccess:@"分享成功" toView:[UIKitTool getAppdelegate].window];
    }
    else
    {
        if ([errorInfo isEqualToString:@""] || errorInfo == nil)
        {
            [MBProgressHUD showError:@"分享失败" toView:[UIKitTool getAppdelegate].window];
        }
        else
        {
            [MBProgressHUD showError:errorInfo toView:[UIKitTool getAppdelegate].window];
        }
    }
}
- (void)tabBackground:(UITapGestureRecognizer *)tapGesture
{
    [self.itemDic removeAllObjects];
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    UIView * blackView = [window viewWithTag:440];
    UIView * shareView = [window viewWithTag:441];
    [UIView animateWithDuration:0.2 animations:^{
        shareView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 270);
    } completion:^(BOOL finished) {
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
    }];
}
- (NSMutableArray *)checkInstall
{
    //判断有没有安装微信和微博。有安装的才让他呈现在分享框里
    if ([self WXInstall]) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"微信好友", @"share_weixin", nil];
        NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"朋友圈", @"share_pengyouquan", nil];
        [self.itemDic addObject:dic];
        [self.itemDic addObject:dic1];
    }
    if ([self QQInstall]) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"QQ好友", @"share_qq", nil];
        [self.itemDic addObject:dic];
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"微博", @"share_weibo", nil];
    [self.itemDic addObject:dic];
    
    return self.itemDic;
}
- (NSMutableArray *)itemDic
{
    if (!_itemDic) {
        _itemDic = [NSMutableArray array];
    }
    return _itemDic;
}
@end
