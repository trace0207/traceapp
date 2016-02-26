//
//  ZHPickView.m
//  ZHpickView
//
//  Created by liudianling on 14-11-18.
//  Copyright (c) 2014年 赵恒志. All rights reserved.
//
#define ZHToobarHeight 40
#import "ZHPickView.h"
#import "TK_ShareCategory.h"
#import "TKUserCenter.h"
#import "UIColor+TK_Color.h"

@interface ZHPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,copy)NSString *plistName;
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,assign)BOOL isLevelArray;
@property(nonatomic,assign)BOOL isLevelString;
@property(nonatomic,assign)BOOL isLevelDic;

@property(nonatomic,assign)BOOL isTKType;
@property(nonatomic,strong)NSObject * resultData;

@property(nonatomic,assign)BOOL isTKGoodsType;
@property(nonatomic,strong)NSDictionary *levelTwoDic;
@property(nonatomic,strong)UIToolbar *toolbar;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,assign)NSDate *defaulDate;
@property(nonatomic,assign)BOOL isHaveNavControler;
@property(nonatomic,assign)NSInteger pickeviewHeight;
@property(nonatomic,copy)NSString *resultString;
@property(nonatomic,strong)NSMutableArray *componentArray;
@property(nonatomic,strong)NSMutableArray *dicKeyArray;
@property(nonatomic,copy)NSMutableArray *state;
@property(nonatomic,copy)NSMutableArray *city;
@property (nonatomic, assign) NSInteger heightOrWeight;
@end

@implementation ZHPickView

-(NSArray *)plistArray{
    if (_plistArray==nil) {
        _plistArray=[[NSArray alloc] init];
    }
    return _plistArray;
}

-(NSArray *)componentArray{

    if (_componentArray==nil) {
        _componentArray=[[NSMutableArray alloc] init];
    }
    return _componentArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBackgroundView];
        [self setUpToolBar];
        [self addGesture];
    }
    return self;
}

- (id)initWithStyle:(HFPicker)picker isHaveNavController:(BOOL)isHaveNavController parameter:(CGFloat)parameter
{
    self = [super init];
    if (self) {
        _heightOrWeight = (NSInteger)parameter;
        NSArray * array = nil;
        if (picker == HF_Height) {
            array = [self getHeightArray];
            self.pickerStyle = HF_Height;
        }
        else if (picker == HF_Weight) {
            self.pickerStyle = HF_Weight;
            array = [self getWeightArray];
        }else if(TK_GoodsType == picker)
        {
         
            self.pickerStyle = HF_Weight;
            array = [TKUserCenter instance].userNormalVM.shareCategorys;
        }
        self.plistArray = array;
        //[self addBackgroundView];
        [self setArrayClass:array];
        [self setUpPickView];
        [self setFrameWith:isHaveNavController];
        [self addGesture];
    }
    return self;
}

-(instancetype)initPickviewWithPlistName:(NSString *)plistName isHaveNavControler:(BOOL)isHaveNavControler{
    
    self=[super init];
    if (self) {
        //[self addBackgroundView];
        _plistName=plistName;
        self.plistArray=[self getPlistArrayByplistName:plistName];
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
        [self addGesture];
    }
    return self;
}
-(instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler{
    self=[super init];
    if (self) {
        //[self addBackgroundView];
        self.plistArray=array;
        [self setArrayClass:array];
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
        [self addGesture];
    }
    return self;
}

-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler{
    
    self=[super init];
    if (self) {
        //[self addBackgroundView];
        self.pickerStyle = HF_BirthDay;
        _defaulDate=defaulDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        [self setFrameWith:isHaveNavControler];
        [self addGesture];
        
    }
    return self;
}
- (void)addBackgroundView
{
    UIPickerView * pickerView = [[UIPickerView alloc] init];
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - pickerView.frame.size.height - ZHToobarHeight)];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0.4;
    [self addSubview:backGroundView];
}
- (void)addGesture{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackground:)];
    [self addGestureRecognizer:tapGesture];
}
-(NSArray *)getPlistArrayByplistName:(NSString *)plistName{
    
    NSString *path= [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray * array=[[NSArray alloc] initWithContentsOfFile:path];
    [self setArrayClass:array];
    return array;
}

-(void)setArrayClass:(NSArray *)array{
    _dicKeyArray=[[NSMutableArray alloc] init];
    for (id levelTwo in array) {
        
        if ([levelTwo isKindOfClass:[NSArray class]]) {
            _isLevelArray=YES;
            _isLevelString=NO;
            _isLevelDic=NO;
        }else if ([levelTwo isKindOfClass:[NSString class]]){
            _isLevelString=YES;
            _isLevelArray=NO;
            _isLevelDic=NO;
            
        }else if ([levelTwo isKindOfClass:[NSDictionary class]])
        {
            _isLevelDic=YES;
            _isLevelString=NO;
            _isLevelArray=NO;
            _levelTwoDic=levelTwo;
            [_dicKeyArray addObject:[_levelTwoDic allKeys] ];
        }else if ([levelTwo isKindOfClass:[TK_ShareCategory class]])
        {
            _isLevelString=NO;
            _isLevelArray=NO;
            _isLevelDic=NO;
            _isTKType = YES;
        }
    }
}

-(void)setFrameWith:(BOOL)isHaveNavControler{
    CGFloat toolViewH = _pickeviewHeight+ZHToobarHeight;
    CGFloat toolViewY ;
    if (isHaveNavControler) {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH-50;
    }else {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH;
    }
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}
-(void)setUpPickView{
    
    UIPickerView *pickView=[[UIPickerView alloc] init];
    pickView.backgroundColor=[UIColor whiteColor];
    _pickerView=pickView;
    pickView.delegate=self;
    pickView.dataSource=self;
    pickView.frame=CGRectMake(0, kScreenHeight - CGRectGetMaxY(pickView.frame), kScreenWidth, pickView.frame.size.height);
    _pickeviewHeight=pickView.frame.size.height;
    [_pickerView selectRow:_heightOrWeight inComponent:0 animated:YES];
    [self addSubview:pickView];
    
}

-(void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode{
    UIDatePicker *datePicker=[[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor=[UIColor whiteColor];
    if (_defaulDate) {
        [datePicker setDate:_defaulDate];
    }
    _datePicker=datePicker;
    datePicker.frame=CGRectMake(0, CGRectGetMaxY(self.toolbar.frame), kScreenWidth, datePicker.frame.size.height);
    _pickeviewHeight=datePicker.frame.size.height;
    [self addSubview:datePicker];
}

-(void)setUpToolBar{
    _toolbar=[self setToolbarStyle];
    [self setToolbarTintColor:[UIColor whiteColor]];
    [self setToolbarWithPickViewFrame];
    [self addBackgroundView];
    [self addSubview:_toolbar];
}
-(UIToolbar *)setToolbarStyle{
    UIToolbar *toolbar=[[UIToolbar alloc] init];
    //toolbar.barTintColor = [UIColor whiteColor];

//    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
//    [lefttem setTintColor:[UIColor blackColor]];
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    [right setTintColor:[UIColor tkThemeColor1]];
    toolbar.items=@[centerSpace/**, lefttem*/, centerSpace, centerSpace, centerSpace, centerSpace, centerSpace, right, centerSpace];
    return toolbar;
}
-(void)setToolbarWithPickViewFrame{
    UIPickerView * pickerView = [[UIPickerView alloc] init];
    _toolbar.frame=CGRectMake(0, kScreenHeight - ZHToobarHeight - pickerView.frame.size.height,[UIScreen mainScreen].bounds.size.width, ZHToobarHeight);
}

#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    NSInteger component = 1;
    if (_isLevelArray) {
        component=_plistArray.count;
    } else if (_isLevelString){
        component=1;
    }else if(_isLevelDic){
        component=[_levelTwoDic allKeys].count*2;
    }else if(_isTKType)
    {
        component=1;
    }
    return component;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *rowArray=[[NSArray alloc] init];
    if (_isLevelArray) {
        rowArray=_plistArray[component];
    }else if (_isLevelString){
        rowArray=_plistArray;
    }else if (_isLevelDic){
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic=_plistArray[pIndex];
        for (id dicValue in [dic allValues]) {
                if ([dicValue isKindOfClass:[NSArray class]]) {
                    if (component%2==1) {
                        rowArray=dicValue;
                    }else{
                        rowArray=_plistArray;
                    }
            }
        }
    }else if(_isTKType)
    {
        rowArray = _plistArray;
    }
    return rowArray.count;
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *rowTitle=nil;
    if (_isLevelArray) {
        rowTitle=_plistArray[component][row];
    }else if (_isLevelString){
        rowTitle=_plistArray[row];
    }else if (_isLevelDic){
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic=_plistArray[pIndex];
        if(component%2==0)
        {
            rowTitle=_dicKeyArray[row][component];
        }
        for (id aa in [dic allValues]) {
           if ([aa isKindOfClass:[NSArray class]]&&component%2==1){
                NSArray *bb=aa;
                if (bb.count>row) {
                    rowTitle=aa[row];
                }
            }
        }
    }else if(_isTKType)
    {
       rowTitle  = ((TK_ShareCategory*)_plistArray[row]).title;
    }
    return rowTitle;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_isLevelDic&&component%2==0) {
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    if (_isLevelString) {
        _resultString=_plistArray[row];
        
    }else if (_isLevelArray){
        _resultString=@"";
        if (![self.componentArray containsObject:@(component)]) {
            [self.componentArray addObject:@(component)];
        }
        for (int i=0; i<_plistArray.count;i++) {
            if ([self.componentArray containsObject:@(i)]) {
                NSInteger cIndex = [pickerView selectedRowInComponent:i];
                _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][cIndex]];
            }else{
                _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][0]];
                          }
        }
    }else if (_isLevelDic){
        if (component==0) {
          _state =_dicKeyArray[row][0];
        }else{
            NSInteger cIndex = [pickerView selectedRowInComponent:0];
            NSDictionary *dicValueDic=_plistArray[cIndex];
            NSArray *dicValueArray=[dicValueDic allValues][0];
            if (dicValueArray.count>row) {
                _city =dicValueArray[row];
            }
        }
    }else if(_isTKType)
    {
        _resultData = _plistArray[row];
    }
}

-(void)remove{
    
    [self removeFromSuperview];
}
-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}
- (void)clickBackground:(UITapGestureRecognizer *)tapGesture
{
    [self removeFromSuperview];
}
-(void)doneClick
{
    if (_pickerView) {
        
        if (_resultString) {
           
        }else{
            if (_isLevelString) {
                _resultString=[NSString stringWithFormat:@"%@",_plistArray[0]];
            }else if (_isLevelArray){
                _resultString=@"";
                for (int i=0; i<_plistArray.count;i++) {
                    _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][0]];
                }
            }else if (_isLevelDic){
                
                if (_state==nil) {
                     _state =_dicKeyArray[0][0];
                    NSDictionary *dicValueDic=_plistArray[0];
                    _city=[dicValueDic allValues][0][0];
                }
                if (_city==nil){
                    NSInteger cIndex = [_pickerView selectedRowInComponent:0];
                    NSDictionary *dicValueDic=_plistArray[cIndex];
                    _city=[dicValueDic allValues][0][0];
                }
              _resultString=[NSString stringWithFormat:@"%@%@",_state,_city];
           }
        }
        
        
        
    }else if (_datePicker) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年M月d日"];
        _resultString=[NSString stringWithFormat:@"%@",[formatter stringFromDate:_datePicker.date]];
    }
    if ([self.delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:cell:)]) {
        [self.delegate toobarDonBtnHaveClick:self resultString:_resultString cell:self.cell];
    }else if([self.delegate respondsToSelector:@selector(tkTooBarComplete:)])
    {
        if(!_resultData && _plistArray.count >0)
        {
            _resultData = _plistArray[0];
        }
        [self.delegate tkTooBarComplete:_resultData];
    }
    [self removeFromSuperview];
}
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color{
    _pickerView.backgroundColor=color;
}
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color{
    
    _toolbar.tintColor=color;
}
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color{
    
    _toolbar.barTintColor=color;
}
- (NSArray *)getHeightArray
{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 300; i++) {
        [array addObject:[NSString stringWithFormat:@"%dcm", i]];
    }
    return [NSArray arrayWithArray:array];
}
- (NSArray *)getWeightArray
{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 300; i++) {
        [array addObject:[NSString stringWithFormat:@"%dkg", i]];
    }
    return [NSArray arrayWithArray:array];
}
-(void)dealloc{
    
    //NSLog(@"销毁了");
}
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
