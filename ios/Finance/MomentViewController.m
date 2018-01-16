//
//  MomentViewController.m
//  Finance
//
//  Created by Bob on 2017/11/19.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "MomentViewController.h"
#import "PacketEntity+CoreDataClass.h"
#import "AddInViewController.h"
#import "PacketMananger.h"

@interface MomentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_packetList;
}

@end

@implementation MomentViewController

- (id)init
{
    self = [super init];
    if (self) {
      _packetList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = [self.moment valueForKey:@"event"];
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
    [self fetchPacketList:NO];
    // Do any additional setup after loading the view.
}

- (void)fetchPacketList:(BOOL)refresh
{
    [[PacketMananger sharedMananger] fetchEntity:@{@"type":@"in",@"eventid":[self.moment valueForKey:@"eventid"]} callback:^(NSError *err, NSArray *entities) {
        if (refresh) {
            [_packetList removeAllObjects];
        }
        [_packetList addObjectsFromArray:entities];
        [_tableView reloadData];
    }];
}


- (void)add:(id)sender
{
    AddInViewController *vc = [[AddInViewController alloc] init];
    vc.moment = self.moment;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _packetList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PacketEntity *entity = [_packetList objectAtIndex:indexPath.row];
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [entity valueForKey:@"name"];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%.2f元", [[entity valueForKey:@"num"] floatValue]];

//    NSDate *date= [entity valueForKey:@"date"];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-mm-dd"];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
    return cell;
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
