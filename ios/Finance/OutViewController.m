//
//  OutViewController.m
//  Finance
//
//  Created by Bob on 2017/6/4.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "OutViewController.h"
#import "PacketMananger.h"
#import "PacketEntity+CoreDataClass.h"
#import "AddOutViewController.h"
#import "BaseTableViewCell.h"

@interface OutViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_packetArr;

}
@end

@implementation OutViewController

- (id)init
{
    self = [super init];
    if (self) {
        _packetArr = [[NSMutableArray alloc] init];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"送礼" image:nil selectedImage:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self fetchPacketList:NO];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self.navigationItem setTitle:@"Some Title"];
//    self.title = @"送礼";
    self.tabBarController.title = @"送礼";
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.tabBarController.navigationItem.rightBarButtonItem =addBtn;
}
- (void)add:(id)sender
{
    AddOutViewController *vc = [[AddOutViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (void)fetchPacketList:(BOOL)refresh{
    [[PacketMananger sharedMananger] fetchEntity:@{@"type":@"out"} callback:^(NSError *err, NSArray *entities) {
        if (refresh) {
            [_packetArr removeAllObjects];
        }
        [_packetArr addObjectsFromArray:entities];
        [_tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PacketEntity *entity = [_packetArr objectAtIndex:indexPath.section];
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.separatorInset = []
                    }
        
        cell.textLabel.text = [entity valueForKey:@"name"];
        cell.detailTextLabel.text =  [NSString stringWithFormat:@"%ld元",[[entity valueForKey:@"num"] integerValue]];
    }
    else
    {
        cell= [tableView dequeueReusableCellWithIdentifier:@"detail"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detail"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSDate *date= [entity valueForKey:@"date"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        cell.textLabel.text  = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
        cell.detailTextLabel.text  = [NSString stringWithFormat:@"%@",[entity  valueForKey:@"category"]];
    }
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _packetArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
 
    
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
