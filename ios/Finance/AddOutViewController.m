//
//  AddOutViewController.m
//  Finance
//
//  Created by Bob on 2017/6/28.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "AddOutViewController.h"
#import "InputTableViewCell.h"
#import "TextTableViewCell.h"
#import <AddressBookUI/AddressBookUI.h>
#import <PDTSimpleCalendar/PDTSimpleCalendar.h>
#import <BlocksKit+UIKit.h>
#import "PacketMananger.h"



@interface AddOutViewController ()<UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate,PDTSimpleCalendarViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITableView *_tableView;
    NSDictionary *_viewModel;
    UITextField *_target;
    NSArray *_categoryArray;
    
}
@end

@implementation AddOutViewController


- (id)init
{
    self = [super init];
    if (self) {
        self.viewType = @"add";
        _viewModel = [[NSMutableDictionary alloc] init];
        [_viewModel setValue:[NSDate date] forKey:@"date"];
        [_viewModel setValue:@"结婚" forKey:@"category"];
        _categoryArray = @[
                           @"结婚",
                           @"乔迁",
                           @"满月",
                           @"生日",
                           @"其他"];
    }
    return self;
}




- (void)setPacket:(PacketEntity *)packet
{
    _packet = packet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写信息";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
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
    
    if (![_viewModel valueForKey:@"name"] ) {
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"请输入名字" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            return ;
        }];
        return;
    }
    if (![_viewModel valueForKey:@"date"] ) {
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"请输入日期" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            return ;
        }];
        return;
    }
    if (![_viewModel valueForKey:@"num"] ) {
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"请输入金额" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            return ;
        }];
        return;
    }
    if (![_viewModel valueForKey:@"phone"] ) {
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"请输入电话" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            return ;
        }];
        return;
    }
    NSMutableDictionary *entity = [[NSMutableDictionary alloc] init];
    [entity setValue:[NSDate date] forKey:@"createAt"];
    [entity setValue:[NSDate date] forKey:@"updateAt"];
    [entity setValue:[_viewModel valueForKey:@"date"] forKey:@"date"];
    [entity setValue:[_viewModel valueForKey:@"name"] forKey:@"name"];
    [entity setValue:[_viewModel valueForKey:@"phone"] forKey:@"phone"];
    [entity setValue:@"out" forKey:@"type"];
    [entity setValue:[_viewModel valueForKey:@"category"] forKey:@"category"];
    [entity setValue:[_viewModel valueForKey:@"num"] forKey:@"num"];
    [entity setValue:@""forKey:@"des"];
    [[PacketMananger  sharedMananger] insertEntity:entity];
    [[PacketMananger  sharedMananger] fetchEntity:@{@"type":@"out"} callback:^(NSError *err, NSArray *entities) {
        NSLog(@"enti:%@",entities);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"text"];
            if (!cell) {
                cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"text"];
            }
            cell.textLabel.text = @"类 型";
            cell.detailTextLabel.text = [_viewModel objectForKey:@"category"]?[_viewModel objectForKey:@"category"]: @"结婚";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        InputTableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"input"];
        if (!cell) {
            cell = [[InputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"input"];
            cell.textField.delegate = self;
        }
        cell.accessoryType  = UITableViewCellAccessoryNone;
        cell.textField.text = @"";
        cell.textField.tag = indexPath.row;
    
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"姓 名";
                cell.textField.placeholder = @"姓名";
                if ([[_viewModel objectForKey:@"name"] length] > 0) {
                    cell.textField.text = [_viewModel objectForKey:@"name"];
                }
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
                break;
            case 1:
//                cell.textField.placeholder = @"类型";
//                if ([_viewModel objectForKey:@"phone"]) {
//                    cell.textField.text = [_viewModel objectForKey:@"phone"];
//                }
                
                break;
            case 2:
                cell.textLabel.text = @"金 额";
                cell.textField.placeholder = @"金额";
                if ([[_viewModel objectForKey:@"num"] length] > 0) {
                    cell.textField.text = [_viewModel objectForKey:@"num"];
                }
                
                break;
            case 3:
                cell.textLabel.text = @"日 期";
                cell.textField.placeholder = @"日期";
                NSDate *date= [_viewModel objectForKey:@"date"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-mm-dd"];
                cell.textField.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
                break;
//            default:
//                break;
        }
        return cell;
    }
    else
    {
        InputTableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"input"];
        if (!cell) {
            cell = [[InputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"input"];
            cell.textField.delegate = self;
        }
        
        cell.textField.text = @"";
        cell.textField.placeholder = @"输入手机号码";
        if ([[_viewModel objectForKey:@"phone"] length]>0) {
            cell.textField.text = [_viewModel objectForKey:@"phone"];
        }
        cell.textField.tag = 10;
        cell.textLabel.text = @"手机号";
        cell.accessoryType  = UITableViewCellAccessoryNone;
        return cell;
    }
    
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"请填写礼金信息";
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ABPeoplePickerNavigationController *vc = [[ABPeoplePickerNavigationController alloc] init];
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],nil];

    
    vc.displayedProperties = displayedItems;
    vc.peoplePickerDelegate = self;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        [_viewModel setValue:textField.text forKey:@"name"];
    }
    if (textField.tag == 2) {
        [_viewModel setValue:textField.text forKey:@"num"];
    }
    if (textField.tag == 10) {
        [_viewModel setValue:textField.text forKey:@"phone"];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_target) {
        [_target resignFirstResponder];
    }
    _target = textField;
    if (textField.tag == 3) {
        
//        PDTSimpleCalendarViewController *vc = [[PDTSimpleCalendarViewController alloc] init];
//        vc.firstDate = [NSDate dateWithTimeIntervalSince1970:0];
//        vc.selectedDate = [_viewModel valueForKey:@"date"];
//        vc.lastDate = [NSDate distantFuture];
//        [self.navigationController pushViewController:vc animated:YES];
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

- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    [self.navigationController popViewControllerAnimated:YES];
    [_viewModel setValue:date forKey:@"date"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row == 1) {
        
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
        UIPickerView *picker = [ [ UIPickerView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,0)];
        picker.delegate = self;
        picker.dataSource = self;
        [picker selectRow:[_categoryArray indexOfObject:[_viewModel objectForKey:@"category"]] inComponent:0 animated:NO]
        ;
        [bgView addSubview: picker];
        
        [picker mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(216);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
            // [datePicker setFrame:CGRectMake(0,self.view.frame.size.height-216,self.view.frame.size.width,216)];
        }];
    }
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _categoryArray.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_viewModel setValue:[_categoryArray objectAtIndex:row] forKey:@"category"];
    [_tableView reloadData];
}

#pragma mark 
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    
    NSString*firstname=(__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (!firstname) {
        firstname = @"";
    }
    NSString*middle=(__bridge NSString *)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
    if (!middle) {
        middle = @"";
    }
    NSString*lastname=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (!lastname) {
        lastname = @"";
    }
    
    [_viewModel setValue:[NSString stringWithFormat:@"%@%@%@",firstname,middle,lastname] forKey:@"name"];
    ABMultiValueRef phones = (ABMultiValueRef)ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phones) >0) {
        
        NSString *mobile;
        
        for (NSInteger i = 0; i < ABMultiValueGetCount(phones); i++) {
            
            if ([(__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, i) isEqualToString:(NSString *)kABPersonPhoneMobileLabel]) {
                mobile = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, i));
                break;
            }
        }
         NSString *phone = mobile ;
        if (!phone) {
            phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, 0));
        }
        [_viewModel setValue:(phone?phone:@"") forKey:@"phone"];
    }
    else{
        
        [_viewModel setValue:@"" forKey:@"phone"];
    }    [_tableView reloadData];
    
    
}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    
    NSString*firstname=(__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (!firstname) {
        firstname = @"";
    }
    NSString*middle=(__bridge NSString *)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
    if (!middle) {
        middle = @"";
    }
    NSString*lastname=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (!lastname) {
        lastname = @"";
    }
    
    [_viewModel setValue:[NSString stringWithFormat:@"%@%@%@",firstname,middle,lastname] forKey:@"name"];
    if (property == kABPersonPhoneProperty) {
         ABMultiValueRef phones = ABRecordCopyValue(person, property);
        NSString *phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, identifier));
        [_viewModel setValue:phone forKey:@"phone"];
    }
    else
    {
        ABMultiValueRef phones = (ABMultiValueRef)ABRecordCopyValue(person, kABPersonPhoneProperty);
        if (ABMultiValueGetCount(phones) >0) {
            NSString *phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, 0));
            [_viewModel setValue:phone forKey:@"phone"];
        }
        else{
            
            [_viewModel setValue:@"" forKey:@"phone"];
            
        }

    }
    [_tableView reloadData];
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
