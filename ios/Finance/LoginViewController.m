//
//  LoginViewController.m
//  Finance
//
//  Created by Bob on 2017/11/19.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    UIImageView *_img;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    _img = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_img];
    _img.backgroundColor = [UIColor blueColor];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-48);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(240);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"使用微信登录" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:22];
//    btn setTitleColor:<#(nullable UIColor *)#> forState:<#(UIControlState)#>
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_img.mas_bottom).with.offset(24);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    [btn bk_whenTapped:^{
        
        
    }];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem =cancelBtn;
    // Do any additional setup after loading the view.
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
