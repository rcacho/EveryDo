//
//  TodoTableViewCell.h
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface TodoTableViewCell : UITableViewCell

@property (weak, nonatomic) Todo *aTodo;

- (void)updateTodoCompletion:(BOOL)isCompleted;

@end
