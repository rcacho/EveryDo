//
//  Todo.m
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "Todo.h"

@implementation Todo


- (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)todoDescription andPriority:(NSNumber *)priority {
    self = [super init];
    if (self) {
        _title = title;
        _todoDescription = todoDescription;
        _priority = priority;
    }
    return self;
}


@end
