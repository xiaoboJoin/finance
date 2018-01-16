//
//  AddInViewController.m
//  Finance
//
//  Created by Bob on 2017/6/28.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "AddInViewController.h"
#import "InputTableViewCell.h"
#import "PacketMananger.h"
@interface AddInViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSMutableDictionary *_viewModel;
    UITextField *_target;
}
@end

@implementation AddInViewController

- (id)init
{
    self = [super init];
    if (self) {
        _viewModel = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem =addBtn;
    
}
- (void)add:(id)sender
{
    if (_target) {
        [_target resignFirstResponder];
    }
    if (![_viewModel objectForKey:@"name"]) {
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"请输入姓名" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            return ;
        }];
        return;
    }
    
    if (![_viewModel objectForKey:@"num"]) {
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"请输入金额" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            return ;
        }];
        return;
    }
    NSMutableDictionary *entity = [[NSMutableDictionary alloc] init];
    [entity setValue:[NSDate date] forKey:@"createAt"];
    [entity setValue:[_viewModel valueForKey:@"name"] forKey:@"name"];
    [entity setValue:[_viewModel valueForKey:@"num"] forKey:@"num"];
    [entity setValue:@"in" forKey:@"type"];
    [entity setValue:[self.moment valueForKey:@"eventid"] forKey:@"eventid"];
    [[PacketMananger  sharedMananger] insertEntity:entity callback:^(NSError *err, NSArray *entities) {
        if (err) {
            [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"请输入金额" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                return ;
            }];
            return;
        }else{
            [[PacketMananger  sharedMananger] fetchEntity:@{@"type":@"in",@"eventid":[self.moment valueForKey:@"eventid"]} callback:^(NSError *err, NSArray *entities) {
                NSLog(@"enti:%@",entities);
            }];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"input"];
    if (!cell) {
        cell = [[InputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"input"];
        cell.textField.delegate = self;
        cell.accessoryType  = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"姓 名";
        cell.textField.text = [_viewModel valueForKey:@"name"];
        cell.textField.placeholder = @"请输入送礼人姓名";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"金 额";
        cell.textField.placeholder = @"请输入送礼金额";
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.text = [_viewModel valueForKey:@"num"];
    }
    cell.textField.tag = indexPath.row;
    return cell;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _target = textField;
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        [_viewModel setValue:textField.text forKey:@"name"];
    }else{
        [_viewModel setValue:textField.text forKey:@"num"];
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
