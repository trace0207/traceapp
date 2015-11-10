//
//  HFPrivacyViewController.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/22.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFPrivacyViewController.h"

#define kInterval 20
#define kIntervalLeft 15
#define kPrivacyLabelWidth kScreenWidth - 30
@interface HFPrivacyViewController ()

@end

@implementation HFPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"用户隐私协议"];
    [self.navigationController addDefaultLeftBarItem];
    [self loadUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadUI
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [self.view addSubview:scrollView];
    
    CGFloat height = 0;
    
    UILabel * topLabel = [[UILabel alloc] init];
    topLabel.numberOfLines = 0;
    topLabel.text = @"sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.mas_top).with.offset(kInterval);
        make.left.equalTo(scrollView.mas_left).with.offset(kIntervalLeft);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    height += topLabel.frame.size.height;
    
    UILabel * label_1 = [[UILabel alloc] init];
    label_1.numberOfLines = 0;
    label_1.text = @"1、个人信息的收集";
    [scrollView addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    height += label_1.frame.size.height;
    
    UILabel * label_1_1 = [[UILabel alloc] init];
    label_1_1.numberOfLines = 0;
    label_1_1.text = @"1.1 个人信息";
    [scrollView addSubview:label_1_1];
    [label_1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_content = [[UILabel alloc] init];
    label_1_content.numberOfLines = 0;
    label_1_content.text = @"sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_content];
    [label_1_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_2 = [[UILabel alloc] init];
    label_1_2.numberOfLines = 0;
    label_1_2.text = @"1.2 为实现服务目的而收集";
    [scrollView addSubview:label_1_2];
    [label_1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_content.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * middleLabel = [[UILabel alloc] init];
    middleLabel.numberOfLines = 0;
    middleLabel.text = @"如果您想使用本“嗨健康”appsfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:middleLabel];
    [middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_1_2_1 = [[UILabel alloc] init];
    label_1_2_1.numberOfLines = 0;
    label_1_2_1.text = @"1.2.1 为实现“嗨健康”的服务目的appsfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_2_1];
    [label_1_2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleLabel.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_2_2 = [[UILabel alloc] init];
    label_1_2_2.numberOfLines = 0;
    label_1_2_2.text = @"1.2.2 为实现“嗨健康”的服务目的appsfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_2_2];
    [label_1_2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_2_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_1_2_3 = [[UILabel alloc] init];
    label_1_2_3.numberOfLines = 0;
    label_1_2_3.text = @"1.2.3 为实现“嗨健康”的服务目的appsfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_2_3];
    [label_1_2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_2_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_3 = [[UILabel alloc] init];
    label_1_3.numberOfLines = 0;
    label_1_3.text = @"1.3 用户提供";
    [scrollView addSubview:label_1_3];
    [label_1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_2_3.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_3_1 = [[UILabel alloc] init];
    label_1_3_1.numberOfLines = 0;
    label_1_3_1.text = @"1.3.1 为实现“嗨健康”的服务目的appsfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_3_1];
    [label_1_3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_3.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_1_3_2 = [[UILabel alloc] init];
    label_1_3_2.numberOfLines = 0;
    label_1_3_2.text = @"1.3.2 为实现“嗨健康”的服务目的appsfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_3_2];
    [label_1_3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_3_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_1_4 = [[UILabel alloc] init];
    label_1_4.numberOfLines = 0;
    label_1_4.text = @"1.4 为实现“嗨健康”的服务目的appsfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_4];
    [label_1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_3_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_4_content = [[UILabel alloc] init];
    label_1_4_content.numberOfLines = 0;
    label_1_4_content.text = @"如果您将信息货其他内容发送给另一个用户，“嗨健康”服务器将会为您保存此信息/内容，并将此信息/内容";
    [scrollView addSubview:label_1_4_content];
    [label_1_4_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_4.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_5 = [[UILabel alloc] init];
    label_1_5.numberOfLines = 0;
    label_1_5.text = @"1.5 您提供信息的其他方式";
    [scrollView addSubview:label_1_5];
    [label_1_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_4_content.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_5_content = [[UILabel alloc] init];
    label_1_5_content.numberOfLines = 0;
    label_1_5_content.text = @"我们将采用其他方式为实现“嗨健康”的服务目的appsfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_5_content];
    [label_1_5_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_5.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_6 = [[UILabel alloc] init];
    label_1_6.numberOfLines = 0;
    label_1_6.text = @"1.6 您的其他信息";
    [scrollView addSubview:label_1_6];
    [label_1_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_5_content.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_1_6_content = [[UILabel alloc] init];
    label_1_6_content.numberOfLines = 0;
    label_1_6_content.text = @"为了便于您使用“嗨健康”app，sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_1_6_content];
    [label_1_6_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_6.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_2 = [[UILabel alloc] init];
    label_2.numberOfLines = 0;
    label_2.text = @"2、个人信息的使用";
    [scrollView addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1_6_content.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_2_1 = [[UILabel alloc] init];
    label_2_1.numberOfLines = 0;
    label_2_1.text = @"2.1 您的个人信息将只在本隐私政策及前提通知您的更新的政策所载明的范围内使用[不会用于其他目的]";
    [scrollView addSubview:label_2_1];
    [label_2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_2_2 = [[UILabel alloc] init];
    label_2_2.numberOfLines = 0;
    label_2_2.text = @"2.2 您的个人信息将只在本隐私政策及前提通知您的更新的政策所载明的范围内使用[不会用于其他目的]";
    [scrollView addSubview:label_2_2];
    [label_2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_2_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_3 = [[UILabel alloc] init];
    label_3.numberOfLines = 0;
    label_3.text = @"3、个人信息的披露";
    [scrollView addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_2_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_3_1 = [[UILabel alloc] init];
    label_3_1.numberOfLines = 0;
    label_3_1.text = @"3.1 除非本隐私政策载明有限披露，我们会妥善保存您的个人信息并不会泄露客户名单";
    [scrollView addSubview:label_3_1];
    [label_3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_3.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_3_2 = [[UILabel alloc] init];
    label_3_2.numberOfLines = 0;
    label_3_2.text = @"3.2 除非本隐私政策载明有限披露，我们会妥善保存您的个人信息并不会泄露客户名单";
    [scrollView addSubview:label_3_2];
    [label_3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_3_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_3_3_1 = [[UILabel alloc] init];
    label_3_3_1.numberOfLines = 0;
    label_3_3_1.text = @"3.2.1 除非本隐私政策载明有限披露，我们会妥善保存您的个人信息并不会泄露客户名单";
    [scrollView addSubview:label_3_3_1];
    [label_3_3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_3_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_3_3_2 = [[UILabel alloc] init];
    label_3_3_2.numberOfLines = 0;
    label_3_3_2.text = @"3.2.12 除非本隐私政策载明有限披露，我们会妥善保存您的个人信息并不会泄露客户名单";
    [scrollView addSubview:label_3_3_2];
    [label_3_3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_3_3_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_3_3_3 = [[UILabel alloc] init];
    label_3_3_3.numberOfLines = 0;
    label_3_3_3.text = @"3.2.3 除非本隐私政策载明有限披露，我们会妥善保存您的个人信息并不会泄露客户名单";
    [scrollView addSubview:label_3_3_3];
    [label_3_3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_3_3_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_4 = [[UILabel alloc] init];
    label_4.numberOfLines = 0;
    label_4.text = @"4、安全";
    [scrollView addSubview:label_4];
    [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_3_3_3.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_4_1 = [[UILabel alloc] init];
    label_4_1.numberOfLines = 0;
    label_4_1.text = @"4.1 对于我们来说，sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_4_1];
    [label_4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_4.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_5 = [[UILabel alloc] init];
    label_5.numberOfLines = 0;
    label_5.text = @"5、您应当协助我们以保护您的个人信息安全。例如，不要泄露您的个人密码";
    [scrollView addSubview:label_5];
    [label_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_4_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_6 = [[UILabel alloc] init];
    label_6.numberOfLines = 0;
    label_6.text = @"6、第三方网站";
    [scrollView addSubview:label_6];
    [label_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_5.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_6_1 = [[UILabel alloc] init];
    label_6_1.numberOfLines = 0;
    label_6_1.text = @"6.1 对于我们来说，sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_6_1];
    [label_6_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_6.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_6_2 = [[UILabel alloc] init];
    label_6_2.numberOfLines = 0;
    label_6_2.text = @"6.2 对于我们来说，sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_6_2];
    [label_6_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_6_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_7 = [[UILabel alloc] init];
    label_7.numberOfLines = 0;
    label_7.text = @"7、本隐私政策的修订";
    [scrollView addSubview:label_7];
    [label_7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_6_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_7_1 = [[UILabel alloc] init];
    label_7_1.numberOfLines = 0;
    label_7_1.text = @"7.1 对于我们来说，sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_7_1];
    [label_7_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_7.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel * label_7_2 = [[UILabel alloc] init];
    label_7_2.numberOfLines = 0;
    label_7_2.text = @"7.2 对于我们来说，sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_7_2];
    [label_7_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_7_1.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_8 = [[UILabel alloc] init];
    label_8.numberOfLines = 0;
    label_8.text = @"8、年龄限制";
    [scrollView addSubview:label_8];
    [label_8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_7_2.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    UILabel * label_8_content = [[UILabel alloc] init];
    label_8_content.numberOfLines = 0;
    label_8_content.text = @" 对于我们来说，sfsafsfsafasfefsfewfwefasfewfzsdfewfewfwefewewttqwrwerewqrewqrqwafwf3fafewasfsdfdssafdsafdsfsfsdfassfasfasfsdfsdfsfsfafaadfs";
    [scrollView addSubview:label_8_content];
    label_8_content.tag = 1098;
    [label_8_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_8.mas_bottom).with.offset(kInterval);
        make.left.equalTo(topLabel.mas_left);
        make.width.mas_equalTo(kPrivacyLabelWidth);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    scrollView.tag = 1099;
}
- (void)viewDidAppear:(BOOL)animated
{
    UILabel * label = (UILabel *)[self.view viewWithTag:1098];
    UIScrollView * scrollView = (UIScrollView *)[self.view viewWithTag:1099];
    scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(label.frame) + 20);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
