//
//  OutViewController.m
//  Finance
//
//  Created by Bob on 2017/6/4.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"

@interface UserViewController ()
{
    UITableView *_tableView;
    NSMutableArray *viewModel;
    
    
}
@end

@implementation UserViewController

- (id)init
{
    self = [super init];
    if (self) {
        viewModel = @[
                      @{@"text":@"设置密码"}];
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:nil selectedImage:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.title = @"个人中心";
    self.tabBarController.navigationItem.rightBarButtonItem =nil;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
         return 1;
    }
    else{
         return 3;
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if (indexPath.section == 0) {
         cell.textLabel.text = @"登录";
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"意见反馈";
        }else if (indexPath.row == 1) {
            cell.textLabel.text = @"给予好评";
        }else if (indexPath.row == 2) {
            cell.textLabel.text = @"分享好友";
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    else{
        return 44;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationController  presentViewController:nav animated:YES completion:^{
            
        }];
    }
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
