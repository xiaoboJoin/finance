//
//  OutViewController.m
//  Finance
//
//  Created by Bob on 2017/6/4.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "InViewController.h"
#import "PacketMananger.h"
//#import "PacketEntity+CoreDataClass.h"
#import "MomentEntity+CoreDataProperties.h"
#import "AddMomentViewController.h"
#import "MomentViewController.h"

@interface InViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_momentList;
    
}
@end

@implementation InViewController

- (id)init
{
    self = [super init];
    if (self) {
        _momentList = [[NSMutableArray alloc] init];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"收礼" image:nil selectedImage:nil];
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
    [self fetchMomentList:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.title = @"收礼";
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.tabBarController.navigationItem.rightBarButtonItem =addBtn;
}
- (void)add:(id)sender
{
    AddMomentViewController *vc = [[AddMomentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fetchMomentList:(BOOL)refresh{
    
    [[PacketMananger sharedMananger] fetchMoment:nil callback:^(NSError *err, NSArray *entities)
     {
     _momentList = [entities mutableCopy];
     [_tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _momentList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MomentEntity *entity = [_momentList objectAtIndex:indexPath.section];
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = [entity valueForKey:@"event"];
        NSDate *date= [entity valueForKey:@"date"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-mm-dd"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
    }
    return cell;
  
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MomentEntity *entity = [_momentList objectAtIndex:indexPath.section];
    MomentViewController *vc = [[MomentViewController alloc] init];
    vc.moment = entity;
    [self.navigationController pushViewController:vc animated:YES];
    
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
