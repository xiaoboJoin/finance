//
//  MomentEntity+CoreDataProperties.h
//  Finance
//
//  Created by Bob on 2017/11/19.
//  Copyright © 2017年 Bob. All rights reserved.
//
//

#import "MomentEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MomentEntity (CoreDataProperties)

+ (NSFetchRequest<MomentEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *person;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *event;
@property (nullable, nonatomic, copy) NSDate *createAt;
@property (nullable, nonatomic, copy) NSDate *updateAt;
@property (nullable, nonatomic, copy) NSString *eventid;
@end

NS_ASSUME_NONNULL_END
