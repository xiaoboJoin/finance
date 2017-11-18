//
//  AddOutViewController.h
//  Finance
//
//  Created by Bob on 2017/6/28.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "BaseViewController.h"
#import "PacketEntity+CoreDataClass.h"

@interface AddOutViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSString *viewType;
@property(nonatomic,strong)PacketEntity *packet;


@end
