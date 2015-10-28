# WYStatusBarHUD
A very good framwork for showing message on the status bar.

## 显示成功信息
```objc
[WYStatusBarHUD showSuccess:@"登录成功!"];
```
## 显示失败信息
```objc
[WYStatusBarHUD showError:@"登录失败!"];
```
## 显示自定义文字
```objc
[WYStatusBarHUD showText:@"我是自定义文字"];
```
## 显示自定义文字+图片
```objc
[WYStatusBarHUD showText:@"自定义文字" imageName:@"test"];
```
## 显示正在加载
```objc
[WYStatusBarHUD showLoading:@"正在登录中..."];
```
## 隐藏
```objc
[WYStatusBarHUD hide];
```
