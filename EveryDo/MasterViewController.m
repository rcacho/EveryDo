//
//  MasterViewController.m
//  EveryDo
//
//  Created by ricardo antonio cacho on 2015-07-15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "TodoTableViewCell.h"

@interface MasterViewController () <UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGestureRecognizer;

@property (weak, nonatomic) IBOutlet UISegmentedControl *todoOrderSegmentedControl;

@property NSMutableArray *outstandingItems;

@property NSMutableArray *completedItems;



@end

@implementation MasterViewController
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    Todo *todo1 = [[Todo alloc] initWithTitle:@"Groceries" andDescription:@"Buy Groceries: this is really long as to test out that the descriptions are being limited to one. I am usure of how long this should be so I am still writing." andPriority:@4 andDeadline:nil];
    Todo *todo2 = [[Todo alloc] initWithTitle:@"Gym" andDescription:@"Go To Gym" andPriority:@3 andDeadline:nil];
    Todo *todo3 = [[Todo alloc] initWithTitle:@"Dry Cleaning" andDescription:@"leave stuff at dry cleaners" andPriority:@5 andDeadline:nil];
    Todo *todo4 = [[Todo alloc] initWithTitle:@"Walk Dog" andDescription:@"Walk The Dog" andPriority:@6 andDeadline:nil];
    Todo *todo5 = [[Todo alloc] initWithTitle:@"Eat Dinner" andDescription:@"Eat Dinner" andPriority:@2 andDeadline:nil];
    Todo *todo6 = [[Todo alloc] initWithTitle:@"Phone Call" andDescription:@"Make Phone Call"
                                  andPriority:@1 andDeadline:nil];
    
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:@[todo1,todo2,todo3,todo4,todo5,todo6]];
    
    self.outstandingItems = objects;
    
    self.completedItems = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.outstandingItems) {
        self.outstandingItems = [[NSMutableArray alloc] init];
    }
    [self performSegueWithIdentifier:@"createNewTodo" sender:self];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.outstandingItems[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    } else if ([[segue identifier] isEqualToString:@"createNewTodo"]) {
        [[segue destinationViewController] setTodoDelegate:self];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.outstandingItems.count;
    }
    return self.completedItems.count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Outstanding Tasks";
    }

        return @"Completed Tasks";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [cell setATodo:self.outstandingItems[indexPath.row]];
        return cell;
    } else {
        [cell setATodo:self.completedItems[indexPath.row]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.outstandingItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Todo *todoToMove = [self.outstandingItems objectAtIndex:sourceIndexPath.row];
    [self.outstandingItems removeObjectAtIndex:sourceIndexPath.row];
    [self.outstandingItems insertObject:todoToMove atIndex:destinationIndexPath.row];
}


#pragma mark - SwipeGestureRecognizer

- (IBAction)swipeToSetAsCompleted:(UISwipeGestureRecognizer *)sender {
    CGPoint point = [self.swipeGestureRecognizer locationInView:self.view];
    NSIndexPath *index = [self.tableView indexPathForRowAtPoint:point];
    Todo *aTodo = [self.outstandingItems objectAtIndex:index.row];
    [self.outstandingItems removeObjectAtIndex:index.row];
    [self.completedItems insertObject:aTodo atIndex:0];
    [aTodo setIsCompleted:YES];
    [self.tableView reloadData];
    
}


#pragma mark - Segmented Control

- (IBAction)orderAccordingToControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self orderByPriority];
    } else if (sender.selectedSegmentIndex == 1) {
        [self orderByDeadline];
    }
}

- (void)orderByPriority {
    NSArray *sortedArray1 = [self.outstandingItems sortedArrayUsingComparator: ^(Todo *todo1, Todo *todo2) {
        NSComparisonResult result = todo1.priority > todo2.priority;
        return result;
    }];
    
    self.outstandingItems = [[NSMutableArray alloc] initWithArray:sortedArray1];
    
    [self.tableView reloadData];
}

- (void)orderByDeadline {
    NSArray *sortedArray1 = [self.outstandingItems sortedArrayUsingComparator: ^(Todo *todo1, Todo *todo2) {
        NSComparisonResult result = todo1.deadline > todo2.deadline;
        return result;
    }];
    
    self.outstandingItems = [[NSMutableArray alloc] initWithArray:sortedArray1];
    
    [self.tableView reloadData];
}


#pragma mark - TodoCreationProtocal

- (void)transferTodo:(Todo *)aTodo {
    [self.outstandingItems insertObject:aTodo atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}

@end
