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

- (void)setContent:(Todo *)aTodo {
    self.todoTitle.text = aTodo.title;
    self.todoPriority.text = [NSString stringWithFormat:@"%ld",(long)[aTodo.priority integerValue]];
    if (aTodo.isCompleted) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:(aTodo.todoDescription)];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        self.todoDescription.attributedText = attributeString;
    } else {
        self.todoDescription.text = aTodo.todoDescription;
    }
}


@end
