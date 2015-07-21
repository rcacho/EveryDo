//
//  TodoTableEntries.m
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-20.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "TodoTableEntries.h"

@interface TodoTableEntries ()

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@property NSMutableArray *listOfTodos;

@property NSString *currentArrangement;

@end

@implementation TodoTableEntries

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.fetchedResultsController performFetch:nil];
        self.listOfTodos = [[NSMutableArray alloc] initWithArray:self.fetchedResultsController.fetchedObjects];
        _currentArrangement = @"priority";
        [self arrangeSectionsByProperty:_currentArrangement];
    }
    return self;
}


- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    CoreDataStack *theCoreDateStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:theCoreDateStack.managedObjectContext sectionNameKeyPath:@"completed" cacheName:@"Todo"];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSFetchRequest *)entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Todo"];
    // note that we have to do something about the fact that the user can chage the orde of the tasks
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    return fetchRequest;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    self.listOfTodos = [[NSMutableArray alloc] initWithArray:self.fetchedResultsController.fetchedObjects];
    [self arrangeSectionsByProperty:self.currentArrangement];
    [self.viewController.tableView reloadData];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.viewController.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation: UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.viewController.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            break;
        case NSFetchedResultsChangeUpdate:
            [self.viewController.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (NSString *)getTitleForHeaderInSection:(NSInteger)section {
    return [self.fetchedResultsController.sections[section] name];
}


- (void)save {
    CoreDataStack *theCoreDataStack = [CoreDataStack defaultStack];
    [theCoreDataStack saveContext];
    
}

#pragma mark - Rearrange Dictionary

- (void)arrangeSectionsByProperty:(NSString *)property {
    NSMutableDictionary *listsByProperties = [self arrangeThroughListsbyProperty:property];
    self.todoDictionary = [[NSDictionary alloc] initWithDictionary:listsByProperties];
    self.currentArrangement = property;
}


- (NSMutableDictionary *)arrangeThroughListsbyProperty:(NSString *)property {
    
    NSMutableDictionary *listsByProperties = [[NSMutableDictionary alloc] init];
    
    for (Todo *aTodo in self.listOfTodos) {
        if([self property:[aTodo propertyForString:property] ExistsInDictionary:listsByProperties]) {
            NSMutableArray *list = [listsByProperties objectForKey:[aTodo propertyForString:property]];
            [list insertObject:aTodo atIndex:0];
        } else {
            NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:aTodo, nil];
            [listsByProperties setObject:list forKey:[aTodo propertyForString:property]];
        }
    }
    return listsByProperties;
}


- (BOOL)property:(NSString *)property ExistsInDictionary:(NSMutableDictionary *)listsByProperties {
    for (NSString *key in listsByProperties.allKeys) {
        if (key == property) {
            return YES;
        }
    }
    return NO;
}

- (void)sortDictionaryByPriority {
    NSArray *tasksToBeCompleted = [self.todoDictionary.allValues[0] sortedArrayUsingComparator: ^(Todo *todo1, Todo *todo2) {
        NSComparisonResult result = todo1.priority > todo2.priority;
        return result;
    }];
    NSArray *tasksCompleted = [self.todoDictionary.allValues[1] sortedArrayUsingComparator: ^(Todo *todo1, Todo *todo2) {
        NSComparisonResult result = todo1.priority > todo2.priority;
        return result;
    }];
    
    self.todoDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:tasksToBeCompleted,@"Tasks To Be Completed",
                           tasksCompleted, @"Tasks Completed", nil];
    [self.viewController.tableView reloadData];
}

- (void)sortDictionaryByDeadline {
    NSArray *tasksToBeCompleted = [self.todoDictionary.allValues[0] sortedArrayUsingComparator: ^(Todo *todo1, Todo *todo2) {
        NSComparisonResult result = todo1.deadline > todo2.deadline;
        return result;
    }];
    NSArray *tasksCompleted = [self.todoDictionary.allValues[1] sortedArrayUsingComparator: ^(Todo *todo1, Todo *todo2) {
        NSComparisonResult result = todo1.deadline > todo2.deadline;
        return result;
    }];
    
    self.todoDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:tasksToBeCompleted,@"Tasks To Be Completed",
                           tasksCompleted, @"Tasks Completed", nil];
    [self.viewController.tableView reloadData];
}

@end
