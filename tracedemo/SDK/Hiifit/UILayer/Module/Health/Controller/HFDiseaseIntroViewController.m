//
//  HFDiseaseIntroViewController.m
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/17.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import "HFDiseaseIntroViewController.h"
#import "GetDiseaseIntroArg.h"
#import "GetDiseaseIntroAck.h"

@interface HFDiseaseIntroViewController ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) GetDiseaseIntroData * data;
@property (nonatomic, strong) UIScrollView * bgScrollView;

@end

@implementation HFDiseaseIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"疾病介绍"];
    [self loadUI];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - privatFunction
- (void)loadData
{
    WS(weakSelf);
    [[[HIIProxy shareProxy] schemeProxy] getDiseaseIntro:self.schemeId withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            GetDiseaseIntroAck * ret = (GetDiseaseIntroAck *)ack;
            weakSelf.data = ret.data;
            [weakSelf setInformation];
        }
    }];
}
- (void)setInformation
{
    self.titleLabel.text = self.data.name;
    NSString * urlStr = self.data.picAddr;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]};
    CGFloat height = [UIKitTool caculateHeight:self.data.content sizeOfWidth:kScreenWidth - 40 withAttributes:attributes];
    self.contentLabel.text = self.data.content;
//    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
    CGFloat originY = CGRectGetMaxY(self.imageView.frame) + 15 + 18 + 10 + 0.5 + 5;
    if (originY + height > kScreenHeight) {
        self.bgScrollView.contentSize = CGSizeMake(kScreenWidth, originY + height + 64);
    }
}
- (void)loadUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.bgScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    [self.view addSubview:self.bgScrollView];
    
    self.imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenScale * 175);
    WS(weakSelf);
    [self.bgScrollView addSubview:self.imageView];
    
    UIView * smallView = [[UIView alloc] init];
    smallView.backgroundColor = [UIColor HFColorStyle_5];
    [self.bgScrollView addSubview:smallView];
    [smallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageView.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(15);
        make.width.mas_equalTo(5);
        make.height.mas_equalTo(18);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.bgScrollView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(smallView.mas_top);
        make.left.equalTo(smallView.mas_right).with.offset(10);
        make.width.mas_equalTo(188);
        make.height.mas_equalTo(18);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.bgScrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(10);
    }];
    
    [self.bgScrollView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(15);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(- 15);
        make.top.equalTo(lineView.mas_bottom).with.offset(5);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
}
#pragma mark - lazyLoading
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        _contentLabel.numberOfLines = 0;
        //_contentLabel.backgroundColor = [UIColor greenColor];
    }
    return _contentLabel;
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
