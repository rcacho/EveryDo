//
//  Todo.h
//  
//
//  Created by ricardo antonio cacho on 2015-07-20.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSString * todoDescription;

@property (nonatomic) int16_t priority;

@property (nonatomic) NSTimeInterval deadline;

@property (nonatomic) BOOL completed;

@property (nonatomic, readonly) NSString *sectionName;

- (NSString *)propertyForString:(NSString *)string;

@end
