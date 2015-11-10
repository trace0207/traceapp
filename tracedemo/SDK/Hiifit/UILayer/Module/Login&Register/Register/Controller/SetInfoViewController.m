//
//  SetInfoViewController.m
//  GuanHealth
//
//  Created by hermit on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SetInfoViewController.h"
#import "TRSDialScrollView.h"
#import "SetHeadViewController.h"
@interface SetInfoViewController ()<TRDialScrollDelegate>
@property (nonatomic, strong)  TRSDialScrollView *weightRuler;
@property (nonatomic, strong)  TRSDialScrollView *heightRuler;
@property (nonatomic, strong)  TRSDialScrollView *yearRuler;
@property (nonatomic, strong)  TRSDialScrollView *mouthRuler;

@property (nonatomic, strong)  UILabel           *weightLabel;
@property (nonatomic, strong)  UILabel           *heightLabel;
@property (nonatomic, strong)  UILabel           *yearLabel;
@property (nonatomic, strong)  UILabel           *mouthLabel;

@property (nonatomic, strong) UIImageView        *boyImageView;
@property (nonatomic, strong) UIImageView        *girlImageView;
@end

#define kPermenentInterval 20
@implementation SetInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"注册信息"];
    [self addRightBarItemWithTitle:@"下一步"];
    
    UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    bgScrollView.backgroundColor = [UIColor HFColorStyle_6];
    bgScrollView.alwaysBounceHorizontal = NO;
    bgScrollView.alwaysBounceVertical = YES;
    [self.view addSubview:bgScrollView];
    if (IS_SCREEN_35_INCH) {
        bgScrollView.contentSize = CGSizeMake(kScreenWidth, bgScrollView.frame.size.height+88+40);
    }
    if (IS_SCREEN_4_INCH) {
        bgScrollView.contentSize = CGSizeMake(kScreenWidth, bgScrollView.frame.size.height+40);
    }
    
    UIButton *girlBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 27, (kScreenWidth/2-16-5),(kScreenWidth/2-16-5) * (226.0/320.0))];
    girlBtn.tag = 0;
    [girlBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:girlBtn];

    UIButton *boyBtn = [[UIButton alloc]initWithFrame:CGRectMake(girlBtn.frame.size.width + 10 + 16, girlBtn.frame.origin.y, girlBtn.frame.size.width, girlBtn.frame.size.height)];
    boyBtn.tag = 1;
    [boyBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:boyBtn];
    
    _boyImageView = [[UIImageView alloc]init];
    _boyImageView.userInteractionEnabled = NO;
    _boyImageView.frame = boyBtn.frame;
    _boyImageView.center = boyBtn.center;
    _boyImageView.image = [UIImage imageNamed:@"boy_normal"];
    _boyImageView.highlightedImage = [UIImage imageNamed:@"boy_highlightedNew"];
    _boyImageView.highlighted = YES;
    [bgScrollView addSubview:_boyImageView];
    
    _girlImageView = [[UIImageView alloc]init];
    _girlImageView.userInteractionEnabled = NO;
    _girlImageView.frame = girlBtn.frame;
    _girlImageView.center = girlBtn.center;
    _girlImageView.image = [UIImage imageNamed:@"girl_normal"];
    _girlImageView.highlightedImage = [UIImage imageNamed:@"girl_highlited"];
    _girlImageView.highlighted = NO;
    [bgScrollView addSubview:_girlImageView];
    
    _weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-80, CGRectGetMaxY(boyBtn.frame) + kPermenentInterval, 160, 30)];
    _weightLabel.font = [UIFont systemFontOfSize:12.0f];
    _weightLabel.textAlignment = NSTextAlignmentCenter;
    _weightLabel.textColor = [UIColor HFColorStyle_2];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"体重70kg"];
    [attString addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:17]
                      range:NSMakeRange(2, 2)];
    _weightLabel.attributedText = attString;
    [bgScrollView addSubview:_weightLabel];
    UIImage *image = [UIImage imageNamed:@"dial_bg"];
    
    _weightRuler = [[TRSDialScrollView alloc]initWithFrame:CGRectMake(16, _weightLabel.frame.origin.y+_weightLabel.frame.size.height+13, kScreenWidth-32, 70)];
    _weightRuler.dialDelegate = self;
    [_weightRuler setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"DialBackground"]]];
    
    [_weightRuler setOverlayImage:image];
    [_weightRuler setLabelFont:[UIFont fontWithName:@"Avenir" size:15]];
    [_weightRuler setLabelFillColor:[UIColor colorWithRed:0.098 green:0.220 blue:0.396 alpha:1.000]];
    [_weightRuler setOverlayColor:[UIColor HFColorStyle_5]];
    [_weightRuler setLabelStrokeWidth:0.1f];
    [_weightRuler setMinorTickLength:15];
    [_weightRuler setMinorTickWidth:1];
    [_weightRuler setMajorTickWidth:2];
    [_weightRuler setMajorTickLength:33];
    [_weightRuler setMajorTickColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4000]];
    [_weightRuler setMinorTickColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3000]];
    [_weightRuler setMinorTicksPerMajorTick:10];
    [_weightRuler setMinorTickDistance:10];
    [_weightRuler setDialRangeFrom:10 to:500];
    [_weightRuler setCurrentValue:70];
    [bgScrollView addSubview:_weightRuler];
    
    _heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-80, _weightRuler.frame.origin.y+_weightRuler.frame.size.height+kPermenentInterval, 160, 30)];
    _heightLabel.font = [UIFont systemFontOfSize:12.0f];
    _heightLabel.textAlignment = NSTextAlignmentCenter;
    _heightLabel.textColor = [UIColor hexChangeFloat:@"000000" withAlpha:0.54f];
    NSMutableAttributedString *heightString = [[NSMutableAttributedString alloc] initWithString:@"身高70cm"];
    [heightString addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:17]
                         range:NSMakeRange(2, 2)];
    _heightLabel.attributedText = heightString;
    [bgScrollView addSubview:_heightLabel];
    
    _heightRuler = [[TRSDialScrollView alloc]initWithFrame:CGRectMake(16, _heightLabel.frame.origin.y+_heightLabel.frame.size.height+13, kScreenWidth-32, 70)];
    _heightRuler.dialDelegate = self;
    [_heightRuler setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"DialBackground"]]];
    [_heightRuler setOverlayImage:image];
    [_heightRuler setLabelFont:[UIFont fontWithName:@"Avenir" size:15]];
    [_heightRuler setLabelFillColor:[UIColor colorWithRed:0.098 green:0.220 blue:0.396 alpha:1.000]];
    [_heightRuler setOverlayColor:[UIColor HFColorStyle_5]];
    [_heightRuler setLabelStrokeWidth:0.1f];
    [_heightRuler setMinorTickLength:15];
    [_heightRuler setMinorTickWidth:1];
    [_heightRuler setMajorTickWidth:2];
    [_heightRuler setMajorTickLength:33];
    [_heightRuler setMajorTickColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4000]];
    [_heightRuler setMinorTickColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3000]];
    [_heightRuler setMinorTicksPerMajorTick:10];
    [_heightRuler setMinorTickDistance:10];
    [_heightRuler setDialRangeFrom:70 to:280];
    [_heightRuler setCurrentValue:170];
    [bgScrollView addSubview:_heightRuler];
    
    _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4-80, _heightRuler.frame.origin.y+_heightRuler.frame.size.height+kPermenentInterval, 160, 30)];
    _yearLabel.font = [UIFont systemFontOfSize:12.0f];
    _yearLabel.textAlignment = NSTextAlignmentCenter;
    _yearLabel.textColor = [UIColor hexChangeFloat:@"000000" withAlpha:0.54f];
    NSMutableAttributedString *yearString = [[NSMutableAttributedString alloc] initWithString:@"出生年1993年"];
    [yearString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:17]
                       range:NSMakeRange(3, 4)];
    _yearLabel.attributedText = yearString;
    [bgScrollView addSubview:_yearLabel];
    
    _yearRuler = [[TRSDialScrollView alloc]initWithFrame:CGRectMake(16, _yearLabel.frame.origin.y+_yearLabel.frame.size.height+13, boyBtn.frame.size.width, 70)];
    _yearRuler.dialDelegate = self;
    [_yearRuler setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"DialBackground"]]];
    [_yearRuler setOverlayImage:image];
    [_yearRuler setLabelFont:[UIFont fontWithName:@"Avenir" size:15]];
    [_yearRuler setLabelFillColor:[UIColor colorWithRed:0.098 green:0.220 blue:0.396 alpha:1.000]];
    [_yearRuler setOverlayColor:[UIColor HFColorStyle_5]];
    [_yearRuler setLabelStrokeWidth:0.1f];
    [_yearRuler setMinorTickLength:15];
    [_yearRuler setMinorTickWidth:1];
    [_yearRuler setMajorTickWidth:2];
    [_yearRuler setMajorTickLength:33];
    [_yearRuler setMajorTickColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4000]];
    [_yearRuler setMinorTickColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3000]];
    [_yearRuler setMinorTicksPerMajorTick:1];
    [_yearRuler setMinorTickDistance:50];
    [_yearRuler setDialRangeFrom:1919 to:2015];
    [_yearRuler setCurrentValue:1993];
    [bgScrollView addSubview:_yearRuler];
    
    _mouthLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 + kScreenWidth/4-80, _heightRuler.frame.origin.y+_heightRuler.frame.size.height+kPermenentInterval, 160, 30)];
    _mouthLabel.font = [UIFont systemFontOfSize:12.0f];
    _mouthLabel.textAlignment = NSTextAlignmentCenter;
    _mouthLabel.textColor = [UIColor hexChangeFloat:@"000000" withAlpha:0.54f];
    NSMutableAttributedString *mouthString = [[NSMutableAttributedString alloc] initWithString:@"出生月2月"];
    [mouthString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:17]
                        range:NSMakeRange(3, 1)];
    _mouthLabel.attributedText = mouthString;
    [bgScrollView addSubview:_mouthLabel];
    
    _mouthRuler = [[TRSDialScrollView alloc]initWithFrame:CGRectMake(kScreenWidth/2 + 5, _yearLabel.frame.origin.y+_yearLabel.frame.size.height+13, boyBtn.frame.size.width, 70)];
    _mouthRuler.dialDelegate = self;
    [_mouthRuler setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"DialBackground"]]];
    [_mouthRuler setOverlayImage:image];
    [_mouthRuler setLabelFont:[UIFont fontWithName:@"Avenir" size:15]];
    [_mouthRuler setLabelFillColor:[UIColor colorWithRed:0.098 green:0.220 blue:0.396 alpha:1.000]];
    [_mouthRuler setOverlayColor:[UIColor HFColorStyle_5]];
    [_mouthRuler setLabelStrokeWidth:0.1f];
    [_mouthRuler setMinorTickLength:15];
    [_mouthRuler setMinorTickWidth:1];
    [_mouthRuler setMajorTickWidth:2];
    [_mouthRuler setMajorTickLength:33];
    [_mouthRuler setMajorTickColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4000]];
    [_mouthRuler setMinorTickColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3000]];
    [_mouthRuler setMinorTicksPerMajorTick:1];
    [_mouthRuler setMinorTickDistance:50];
    [_mouthRuler setDialRangeFrom:1 to:12];
    [_mouthRuler setCurrentValue:2];
    [bgScrollView addSubview:_mouthRuler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectSex:(UIButton*)btn
{
    if (btn.tag) {
        self.boyImageView.highlighted = YES;
        self.girlImageView.highlighted = NO;
    }else{
        self.boyImageView.highlighted = NO;
        self.girlImageView.highlighted = YES;
    }
}

- (void)leftBarItemAction:(id)sender
{
    HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"新用户必须完善信息才能正常使用！" commpleteBlock:^(NSInteger buttonIndex) {
        
    } cancelTitle:@"" determineTitle:_T(@"HF_Common_OK")];
    [alter show];
}

- (void)rightBarItemAction:(id)sender
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    int sex = 0;
    if (self.girlImageView.highlighted) {
        sex = 1;
    }
    CGFloat weight = _weightRuler.currentValue;

    CGFloat height = _heightRuler.currentValue;
    
    NSString *year = [NSString stringWithFormat:@"%i",(int)_yearRuler.currentValue];
    
    NSString *mouth = [NSString stringWithFormat:@"%i",(int)_mouthRuler.currentValue];
    
    [dic setObject:[NSNumber numberWithInt:sex] forKey:kParamSex];
    [dic setObject:[NSNumber numberWithFloat:weight] forKey:kParamWeight];
    [dic setObject:[NSNumber numberWithFloat:height] forKey:kParamHeight];
    [dic setObject:year forKey:kParamYear];
    [dic setObject:mouth forKey:kParamMonth];
    
    SetHeadViewController *vc = [[SetHeadViewController alloc]init];
   // vc.isFromMainView = self.isFromMainView;
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma dial delegate

- (void)dialEndScrollView:(TRSDialScrollView *)scrollView WithValue:(CGFloat)value
{
    NSString *valueStr = @"";
    if ([scrollView isEqual:_weightRuler]) {
        valueStr = [NSString stringWithFormat:@"体重%ikg",(int)value];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:valueStr];
        [attString addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:17]
                          range:NSMakeRange(2, valueStr.length-4)];
        self.weightLabel.attributedText = attString;
    }else if ([scrollView isEqual:_heightRuler]){
        valueStr = [NSString stringWithFormat:@"身高%icm",(int)value];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:valueStr];
        [attString addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:17]
                          range:NSMakeRange(2, valueStr.length-4)];
        self.heightLabel.attributedText = attString;
    }else if ([scrollView isEqual:_yearRuler]){
        valueStr = [NSString stringWithFormat:@"出生年%i年",(int)value];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:valueStr];
        [attString addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:17]
                          range:NSMakeRange(3, valueStr.length-4)];
        self.yearLabel.attributedText = attString;
    }else if ([scrollView isEqual:_mouthRuler]){
        valueStr = [NSString stringWithFormat:@"出生月%i月",(int)value];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:valueStr];
        [attString addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:17]
                          range:NSMakeRange(3, valueStr.length-4)];
        self.mouthLabel.attributedText = attString;
    }
}
@end
