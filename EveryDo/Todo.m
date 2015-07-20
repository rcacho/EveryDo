//
//  Todo.m
//  
//
//  Created by ricardo antonio cacho on 2015-07-20.
//
//

#import "Todo.h"


@implementation Todo

@dynamic title;

@dynamic todoDescription;

@dynamic priority;

@dynamic deadline;

@dynamic completed;

- (NSString *)sectionName {
    if (self.completed) {
        return @"Completed Tasks:";
    } else {
        return @"Outstanding Tasks:";
    }
}


@end
