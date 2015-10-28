//
//  WYStatusBarHUD.m
//  WYStatusBarHUDDemo
//
//  Created by pro on 15/10/28.
//  Copyright © 2015年 WY. All rights reserved.
//

#import "WYStatusBarHUD.h"

@implementation WYStatusBarHUD

static NSTimer *timer_;
static UIWindow *window_;

/** window出现时间 + 逗留时间 */
static CGFloat const WYStayDuration = 1.75;
/** window出现和隐藏的动画时长 */
static CGFloat const WYAnimationDuration = 0.25;
/** 图片和文字之间的间距 */
static CGFloat const WYTitleImageMargin = 10.0;

#pragma mark - 私有方法
+ (void)setupText:(NSString *)text image:(UIImage *)image
{
    CGRect windowF = [UIApplication sharedApplication].statusBarFrame;
    
    // 创建
    window_ = [[UIWindow alloc] init];
    window_.frame = windowF;
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    window_.backgroundColor = [UIColor blackColor];
    
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = window_.bounds;
    [window_ addSubview:button];
    
    // 设置按钮数据
    [button setTitle:text forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    
    // 其他设置
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    if (image) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, WYTitleImageMargin, 0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYTitleImageMargin);
    }
    
    // window出现的动画
    CGRect beginWindowF = windowF;
    beginWindowF.origin.y = - beginWindowF.size.height;
    window_.frame = beginWindowF;
    [UIView animateWithDuration:WYAnimationDuration animations:^{
        window_.frame = windowF;
    }];
}


#pragma mark - 公共方法
/**
 *  显示图片+文字信息
 */
+ (void)showText:(NSString *)text image:(UIImage *)image
{
    // 根据文字和图片做一些初始化操作
    [self setupText:text image:image];
    
    // 停止上次的定时器
    [timer_ invalidate];
    // 开启新的定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:WYStayDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 *  显示图片+文字信息
 */
+ (void)showText:(NSString *)text imageName:(NSString *)imageName
{
    [self showText:text image:[UIImage imageNamed:imageName]];
}

/**
 *  显示文字信息
 */
+ (void)showText:(NSString *)text
{
    [self showText:text image:nil];
}

/**
 *  显示成功信息
 */
+ (void)showSuccess:(NSString *)text
{
    [self showText:text imageName:@"WYStatusBarHUD.bundle/success"];
}

/**
 *  显示失败信息
 */
+ (void)showError:(NSString *)text
{
    [self showText:text imageName:@"WYStatusBarHUD.bundle/error"];
}

/**
 *  显示正在加载的信息
 */
+ (void)showLoading:(NSString *)text
{
    // 根据文字和图片做一些初始化操作
    [self setupText:text image:nil];
    
    CGRect windowF = window_.frame;
    UIButton *button = window_.subviews.lastObject;
    
    // 添加圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    
    [button.titleLabel sizeToFit];
    CGFloat loadingCenterX = (windowF.size.width - button.titleLabel.frame.size.width) * 0.5 - 20;
    loadingView.center = CGPointMake(loadingCenterX, windowF.size.height * 0.5);
    [window_ addSubview:loadingView];
}

/**
 *  隐藏指示器
 */
+ (void)hide
{
    // 停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 隐藏
    [UIView animateWithDuration:WYAnimationDuration animations:^{
        CGRect beginWindowF = window_.frame;
        beginWindowF.origin.y = - beginWindowF.size.height;
        window_.frame = beginWindowF;
    } completion:^(BOOL finished) {
        // 如果定时器是nil, 说明这个hide动画期间, 没有创建任何新的窗口
        if (timer_ == nil) window_ = nil;
    }];
}


@end
