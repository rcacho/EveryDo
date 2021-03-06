//
//  TodoTableViewCell.m
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "TodoTableViewCell.h"

@interface TodoTableViewCell () 

@property (weak, nonatomic) IBOutlet UILabel *todoTitle;

@property (nonatomic) IBOutlet UILabel *todoDescription;

@property (weak, nonatomic) IBOutlet UILabel *todoPriority;

@property (weak, nonatomic) IBOutlet UILabel *todoDate;

@end


@implementation TodoTableViewCell

- (void)setATodo:(Todo *)aTodo{
    _aTodo = aTodo;
    [self setContent];
}

- (void)setContent {
    self.todoTitle.text = self.aTodo.title;
    self.todoPriority.text = [NSString stringWithFormat:@"%hd",self.aTodo.priority];
    self.todoDate.text = [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:self.aTodo.deadline]
                                                        dateStyle:NSDateFormatterShortStyle
                                                        timeStyle:NSDateFormatterShortStyle];
    if (self.aTodo.completed) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:(self.aTodo.todoDescription)];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        self.todoDescription.attributedText = attributeString;
    } else {
        self.todoDescription.text = self.aTodo.todoDescription;
    }
}

- (void)updateTodoCompletion:(BOOL)isCompleted {
    self.aTodo.completed = YES;
    [self setContent];
}


@end
