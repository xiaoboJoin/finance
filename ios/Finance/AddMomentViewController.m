//
//  AddMomentViewController.m
//  Finance
//
//  Created by Bob on 2017/11/19.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "AddMomentViewController.h"
#import "TextInputTableViewCell.h"
#import "TextTableViewCell.h"
#import "InputTableViewCell.h"
#import "MomentEntity+CoreDataProperties.h"
#import "PacketMananger.h"

@interface AddMomentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSMutableDictionary *_viewModel;
    UITextField *_target;
}
@end

@implementation AddMomentViewController
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
    self.title = @"创建大事件";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem =addBtn;
    // Do any additional setup after loading the view.
}

- (void)done:(id)sender
{
    if (_target) {
        [_target resignFirstResponder];
    }
    if (![_viewModel valueForKey:@"event"] ) {
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"请输入事件名称" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            return ;
        }];
        return;
    }
    NSMutableDictionary *entity = [[NSMutableDictionary alloc] init];
    [entity setValue:[NSDate date] forKey:@"createAt"];
    [entity setValue:[_viewModel valueForKey:@"date"] forKey:@"date"];
    [entity setValue:[_viewModel valueForKey:@"event"] forKey:@"event"];
    [[PacketMananger  sharedMananger] insertMoment:entity callback:^(NSError *err, NSArray *entities) {
        if (err) {
            [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"创建失败，请重试！" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                return ;
            }];
        }else{
            [[PacketMananger  sharedMananger] fetchMoment:@{} callback:^(NSError *err, NSArray *entities) {
                NSLog(@"enti:%@",entities);
            }];
        }
    }];
   
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section == 0) {
        TextInputTableViewCell *cell = nil;
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TextInputTableViewCell"];
            if (!cell) {
                cell = [[TextInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textField.delegate = self;
            cell.textField.placeholder = @"请填写事件名称";
            cell.textField.text = [_viewModel valueForKey:@"event"];
        }
        return cell;
    }else{
        InputTableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"input"];
        if (!cell) {
            cell = [[InputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"input"];
            cell.textField.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"日 期";
        cell.textField.placeholder = @"日期";
        cell.textField.tag = indexPath.section;
        cell.textField.text = @"";
        if ([_viewModel objectForKey:@"date"]) {
            NSDate *date= [_viewModel objectForKey:@"date"];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-mm-dd"];
            cell.textField.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
        }
        return cell;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
         return @"事件名称";
    }
    else{
        return @"事件时间";
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_target) {
        [_target resignFirstResponder];
    }
    _target = textField;
    if (textField.tag == 1) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        __weak typeof(UIView) *weakView = bgView;
        [bgView bk_whenTapped:^{
            [weakView removeFromSuperview];
        }];
        
        UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,0)];
            //        datePicker.backgroundColor = [UIColor whiteColor];
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        [bgView addSubview: datePicker];
        [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(216);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
                // [datePicker setFrame:CGRectMake(0,self.view.frame.size.height-216,self.view.frame.size.width,216)];
            
            
        }];
        
        
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        
        return NO;
    }
    return YES;
}

- (void)dateChanged:(UIDatePicker *)sender
{
    [_viewModel setValue:sender.date forKey:@"date"];
    [_tableView reloadData];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        [_viewModel setValue:textField.text forKey:@"event"];
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
