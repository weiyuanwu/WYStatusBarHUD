//
//  ViewController.m
//  WYStatusBarHUDDemo
//
//  Created by pro on 15/10/28.
//  Copyright © 2015年 WY. All rights reserved.
//

#import "ViewController.h"
#import "WYStatusBarHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)success {
    [WYStatusBarHUD showSuccess:@"登录成功!"];
}

- (IBAction)error {
    [WYStatusBarHUD showError:@"登录失败!"];
}

- (IBAction)showText {
    [WYStatusBarHUD showText:@"我是自定义文字"];
}

- (IBAction)showTextAndImage {
    [WYStatusBarHUD showText:@"自定义文字" imageName:@"test"];
}

- (IBAction)loading {
    [WYStatusBarHUD showLoading:@"正在登录中..."];
}

- (IBAction)hide {
    [WYStatusBarHUD hide];
}



@end
