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

- (void)insertNewTodoEntry {
    CoreDataStack *theCoreDataStack = [CoreDataStack defaultStack];
    Todo *aTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:
                         theCoreDataStack.managedObjectContext];
    aTodo.title = self.todoTitleTextField.text;
    aTodo.todoDescription = self.todoDescriptionTextField.text;
    aTodo.priority = [self.todoPriorityTextField.text intValue];
    aTodo.deadline = [self.todoDeadlinePicker.date timeIntervalSince1970];
    aTodo.completed = NO;

    
    [self.delegate saveTodo];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)createNewTodo:(UIButton *)sender {
    if ([self validateFields]) {
        [self insertNewTodoEntry];
    }
}

- (BOOL)validateFields {
    return ((self.todoTitle != nil) && (self.todoPriority != nil) && (self.todoDescription != nil));
}

@end
