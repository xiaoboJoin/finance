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

-(void)insertEntity:(id)object callback:(fetchBlock)block;
-(BOOL)updateEntity:(id)object;
-(BOOL)deleteEntity:(id)object;
-(void)fetchEntity:(NSDictionary *)condition callback:(fetchBlock)block;

- (void)insertMoment:(id)object callback:(fetchBlock)block;
- (BOOL)updateMoment:(id)object;
- (BOOL)deleteMoment:(id)object;
-(void)fetchMoment:(NSDictionary *)params callback:(fetchBlock)block;

@end
