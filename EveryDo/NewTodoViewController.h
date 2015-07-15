//
//  NewTodoViewController.h
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"


@protocol TodoCreationProtocol <NSObject>

- (void)transferTodo:(Todo *)aTodo;

@end

@interface NewTodoViewController : UIViewController

@property id<TodoCreationProtocol> todoDelegate;

@end
