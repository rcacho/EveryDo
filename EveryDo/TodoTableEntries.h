//
//  TodoTableEntries.h
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-20.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"
#import "CoreDataStack.h"
#import "MasterViewController.h"

@interface TodoTableEntries : NSObject <NSFetchedResultsControllerDelegate>

@property NSDictionary *todoDictionary;

@property MasterViewController *viewController;

- (NSString *)getTitleForHeaderInSection:(NSInteger)section;

- (void)save;

@end
