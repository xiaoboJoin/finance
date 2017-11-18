//
//  PacketMananger.h
//  Finance
//
//  Created by Bob on 2017/6/27.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^fetchBlock)(NSError *err,NSArray *entities);


@interface PacketMananger : NSObject
@property(nonatomic,readonly,strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic,readonly,strong)NSManagedObjectModel *managedObjectModel;
@property(nonatomic,readonly,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;
+(id)sharedMananger;

-(void)insertEntity:(id)object;
-(void)updateEntity:(id)object;
-(void)deleteEntity:(id)object;
-(void)fetchEntity:(NSDictionary *)condition callback:(fetchBlock)block;
@end
