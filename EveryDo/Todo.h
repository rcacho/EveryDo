//
//  Todo.h
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property NSString *title;

@property NSString *todoDescription;

@property NSNumber *priority;

@property NSDate *deadline;

@property BOOL isCompleted;

- (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)todoDescription andPriority:(NSNumber *)priority andDeadline:(NSDate *)deadline;

@end
