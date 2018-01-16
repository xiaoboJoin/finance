//
//  PacketEntity+CoreDataProperties.h
//  Finance
//
//  Created by Bob on 2017/6/27.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "PacketEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PacketEntity (CoreDataProperties)

+ (NSFetchRequest<PacketEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSDate *createAt;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *des;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) float num;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *eventid;
@property (nullable, nonatomic, copy) NSDate *updateAt;

@end

NS_ASSUME_NONNULL_END
