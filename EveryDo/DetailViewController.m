//
//  DetailViewController.m
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *todoPriorityLabel;

@property (weak, nonatomic) IBOutlet UILabel *todoTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *todoDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *todoDate;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.todoPriorityLabel.text = [NSString stringWithFormat:@"%ld",[self.detailItem.priority integerValue]];
        self.todoTitleLabel.text = self.detailItem.title;
        self.todoDate.text = [NSDateFormatter localizedStringFromDate:self.detailItem.deadline
                                                            dateStyle:NSDateFormatterShortStyle
                                                            timeStyle:NSDateFormatterShortStyle];
        if (self.detailItem.isCompleted) {
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:(self.detailItem.todoDescription)];
            [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                    value:@2
                                    range:NSMakeRange(0, [attributeString length])];
            self.todoDescriptionLabel.attributedText = attributeString;
        } else {
            self.todoDescriptionLabel.text = self.detailItem.todoDescription;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
