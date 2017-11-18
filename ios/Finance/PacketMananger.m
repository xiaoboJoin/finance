//
//  PacketMananger.m
//  Finance
//
//  Created by Bob on 2017/6/27.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "PacketMananger.h"
#import "PacketEntity+CoreDataClass.h"

@implementation PacketMananger
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize managedObjectContext=_managedObjectContext;



+(id)sharedMananger
{
    static PacketMananger *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}



- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}





- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return  _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
    
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Finance.sqlite"];
    NSError *err = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&err]) {
        abort();
    }
    return _persistentStoreCoordinator;
}


- (NSManagedObjectModel *)managedObjectModel
{
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"Finance" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    return _managedObjectModel;
}


#pragma mark - Core Data Saving support


-(void)insertEntity:(id)object
{
    NSManagedObject *newEntity = [NSEntityDescription insertNewObjectForEntityForName:@"PacketEntity" inManagedObjectContext:[[PacketMananger sharedMananger] managedObjectContext]];
    // 实体对象存储属性值（相当于数据库中将一个值存入对应字段
    [newEntity setValue:[object valueForKey:@"createAt"] forKey:@"createAt"];
    [newEntity setValue:[object valueForKey:@"updateAt"] forKey:@"updateAt"];
    [newEntity setValue:[object valueForKey:@"date"] forKey:@"date"];
    [newEntity setValue:[object valueForKey:@"name"] forKey:@"name"];
    [newEntity setValue:[object valueForKey:@"phone"] forKey:@"phone"];
    [newEntity setValue:[object valueForKey:@"type"] forKey:@"type"];
    [newEntity setValue:[object valueForKey:@"category"] forKey:@"category"];
    [newEntity setValue:@([[object valueForKey:@"num"] integerValue]) forKey:@"num"];
    [newEntity setValue:[object valueForKey:@"des"] forKey:@"des"];
    // 保存信息，同步数据
    NSError *error = nil;
    BOOL result = [self.managedObjectContext save:&error];
}

-(void)updateEntity:(id)object
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@", [object valueForKey:@"createAt"]];
    NSFetchRequest * fetch = [PacketEntity fetchRequest];
    [fetch setPredicate:predicate];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"<#Entity name#>" inManagedObjectContext:<#context#>];
//    [fetchRequest setEntity:entity];
//    // Specify criteria for filtering which objects to fetch
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
//    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
//                                                                   ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    if (fetchedObjects != nil) {
        NSManagedObject* newEntity = [fetchedObjects objectAtIndex:0];
        [newEntity setValue:[object valueForKey:@"createAt"] forKey:@"createAt"];
        [newEntity setValue:[object valueForKey:@"updateAt"] forKey:@"updateAt"];
        [newEntity setValue:[object valueForKey:@"date"] forKey:@"date"];
        [newEntity setValue:[object valueForKey:@"name"] forKey:@"name"];
        [newEntity setValue:[object valueForKey:@"phone"] forKey:@"phone"];
        [newEntity setValue:[object valueForKey:@"type"] forKey:@"type"];
        [newEntity setValue:[object valueForKey:@"category"] forKey:@"category"];
        [newEntity setValue:[object valueForKey:@"num"] forKey:@"num"];
        [newEntity setValue:[object valueForKey:@"des"] forKey:@"des"];
        // 保存信息，同步数据
        NSError *error = nil;
        BOOL result = [self.managedObjectContext save:&error];
        
    }
}
-(void)deleteEntity:(id)object
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@", [object valueForKey:@"createAt"]];
    NSFetchRequest * fetch = [PacketEntity fetchRequest];
    [fetch setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    for (NSManagedObject *obj in fetchedObjects) {
        [self.managedObjectContext deleteObject:obj];
    }
}
-(void)fetchEntity:(NSDictionary *)params callback:(fetchBlock)block
{
    
//    NSError *error = nil;
//    NSFetchRequest * fetch = [PacketEntity fetchRequest];
    NSMutableDictionary *condition = [params mutableCopy];
    if (![condition valueForKey:@"offset"]) {
        [condition setValue:@(0) forKey:@"offset"];
    }
    if (![condition valueForKey:@"limit"]) {
        [condition setValue:@(24) forKey:@"limit"];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.fetchOffset = [[condition valueForKey:@"offset"] integerValue];
    fetchRequest.fetchLimit = [[condition valueForKey:@"limit"] integerValue];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PacketEntity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type==%@", [condition valueForKey:@"type"]];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createAt"
                                                                   ascending:NO];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects) {
        if (block) {
            block(nil,fetchedObjects);
        }
    }
    else
    {
        if (block) {
            block(nil,nil);
        }
    }
    
//    NSArray * results = [self.managedObjectContext executeFetchRequest:fetch error:&error];
//    if (error) {
//        block(error,nil);
//    }
//    else
//    {
//        block(nil,results);
//    }
}


@end
