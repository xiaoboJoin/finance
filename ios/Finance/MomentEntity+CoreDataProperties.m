//
//  MomentEntity+CoreDataProperties.m
//  Finance
//
//  Created by Bob on 2017/11/19.
//  Copyright © 2017年 Bob. All rights reserved.
//
//

#import "MomentEntity+CoreDataProperties.h"

@implementation MomentEntity (CoreDataProperties)

+ (NSFetchRequest<MomentEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MomentEntity"];
}

@dynamic type;
@dynamic date;
@dynamic person;
@dynamic location;
@dynamic event;
@dynamic createAt;
@dynamic updateAt;
@dynamic eventid;

@end
