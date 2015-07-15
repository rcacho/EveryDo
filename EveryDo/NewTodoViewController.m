//
//  NewTodoViewController.m
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "NewTodoViewController.h"

@interface NewTodoViewController () <UITextFieldDelegate>

@property NSString *todoTitle;

@property NSNumber *todoPriority;

@property NSString *todoDescription;

@property (weak, nonatomic) IBOutlet UITextField *todoTitleTextField;

@property (weak, nonatomic) IBOutlet UITextField *todoPriorityTextField;

@property (weak, nonatomic) IBOutlet UITextField *todoDescriptionTextField;

@property (weak, nonatomic) IBOutlet UIDatePicker *todoDeadlinePicker;

@end

@implementation NewTodoViewController


- (void)viewDidLoad {
    self.todoTitleTextField.delegate = self;
    self.todoPriorityTextField.delegate = self;
    self.todoDescriptionTextField.delegate = self;
}


#pragma mark TextFields

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"it did begin");
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.todoTitleTextField) {
        self.todoTitle = textField.text;
    } else if (textField == self.todoPriorityTextField) {
        self.todoPriority = [NSNumber numberWithInteger: [textField.text integerValue]];
    } else if (textField == self.todoDescriptionTextField) {
        self.todoDescription = textField.text;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"text sumbitted");
    return [textField resignFirstResponder];
}



#pragma mark Buttons

- (IBAction)createNewTodo:(UIButton *)sender {
    if ([self validateFields]) {
        Todo *newTodo = [[Todo alloc] initWithTitle:self.todoTitle andDescription:self.todoDescription andPriority:self.todoPriority andDeadline:self.todoDeadlinePicker.date];
        [self.todoDelegate transferTodo:newTodo];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
}

- (BOOL)validateFields {
    return ((self.todoTitle != nil) && (self.todoPriority != nil) && (self.todoDescription != nil));
}

@end
