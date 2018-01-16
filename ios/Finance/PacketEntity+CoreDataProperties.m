//
//  PacketEntity+CoreDataProperties.m
//  Finance
//
//  Created by Bob on 2017/6/27.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "PacketEntity+CoreDataProperties.h"

@implementation PacketEntity (CoreDataProperties)

+ (NSFetchRequest<PacketEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"PacketEntity"];
}

@dynamic category;
@dynamic createAt;
@dynamic date;
@dynamic des;
@dynamic name;
@dynamic num;
@dynamic phone;
@dynamic type;
@dynamic updateAt;
@dynamic eventid;

@end
