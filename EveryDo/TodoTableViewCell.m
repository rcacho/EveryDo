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

@end


@implementation TodoTableViewCell

- (void)setTitle:(NSString *)aTitle {
    self.todoTitle.text = aTitle;
}


- (void)setDescription:(NSString *)aDescription {
    self.todoDescription.text = aDescription;
}

- (void)setATodo:(Todo *)aTodo{
    _aTodo = aTodo;
    [self setContent];
}

- (void)setContent {
    self.todoTitle.text = self.aTodo.title;
    self.todoPriority.text = [NSString stringWithFormat:@"%ld",(long)[self.aTodo.priority integerValue]];
    if (self.aTodo.isCompleted) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:(self.aTodo.todoDescription)];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        self.todoDescription.attributedText = attributeString;
    } else {
        self.todoDescription.text = self.aTodo.todoDescription;
    }
}



@end
