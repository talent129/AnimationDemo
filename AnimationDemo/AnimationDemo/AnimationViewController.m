//
//  AnimationViewController.m
//  AnimationDemo
//
//  Created by iMac on 16/5/24.
//  Copyright © 2016年 Cai. All rights reserved.
//

#import "AnimationViewController.h"
#import "Masonry.h"
#import "MBProgressHUD.h"

@interface AnimationViewController ()

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) MBProgressHUD *progressHud;

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIImageView *lineImgView;

@end

@implementation AnimationViewController

#pragma mark -lazyLoad
- (MBProgressHUD *)progressHud
{
    if (_progressHud == nil) {
        _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHud.mode = MBProgressHUDModeCustomView;
        _progressHud.customView = self.customView;
        _progressHud.removeFromSuperViewOnHide = YES;
    }
    return _progressHud;
}

- (UIView *)customView
{
    if (_customView == nil) {
        _customView = [[UIView alloc] init];
        _customView.backgroundColor = [UIColor clearColor];
        _customView.frame = CGRectMake(0, 0, 60, 60);
        
        [_customView addSubview:self.bgImgView];
        [_customView addSubview:self.lineImgView];
        
        UIView *view = _customView;
        [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        
        [self.lineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        
    }
    return _customView;
}

- (UIImageView *)bgImgView
{
    if (_bgImgView == nil) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = [UIImage imageNamed:@"load_bg"];
    }
    return _bgImgView;
}

- (UIImageView *)lineImgView
{
    if (_lineImgView == nil) {
        _lineImgView = [[UIImageView alloc] init];
        _lineImgView.image = [UIImage imageNamed:@"line"];
    }
    return _lineImgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"动画";
    
    [self initView];
    
}

- (void)initView
{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.backgroundColor = [UIColor cyanColor];
    [startBtn setTitle:@"开始动画" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAnimationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    __weak typeof(self) weakSelf = self;
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(100, 39));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"开始动画后 3秒动画结束";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor purpleColor];
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(startBtn.mas_bottom).offset(30);
    }];
}

- (void)startAnimationAction
{
    [self startAnimation];
    
    [self.progressHud showAnimated:YES];
    
    [self.view addSubview:self.progressHud];
    
    [self performSelector:@selector(stopAnimationAction) withObject:nil afterDelay:3];
}

- (void)stopAnimationAction
{
    [self stopAnimation];

    [self.progressHud hideAnimated:YES];

    [self.progressHud removeFromSuperview];
}

- (void)startAnimation
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 2;
    rotationAnimation.repeatCount = NSIntegerMax;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.lineImgView.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}

- (void)stopAnimation
{
    [self.lineImgView.layer removeAllAnimations];
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
