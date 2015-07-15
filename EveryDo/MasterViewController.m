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

@property NSMutableArray *objects;

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
    
    Todo *todo1 = [[Todo alloc] initWithTitle:@"Groceries" andDescription:@"Buy Groceries: this is really long as to test out that the descriptions are being limited to one. I am usure of how long this should be so I am still writing." andPriority:@4];
    Todo *todo2 = [[Todo alloc] initWithTitle:@"Gym" andDescription:@"Go To Gym" andPriority:@3];
    Todo *todo3 = [[Todo alloc] initWithTitle:@"Dry Cleaning" andDescription:@"leave stuff at dry cleaners" andPriority:@5];
    Todo *todo4 = [[Todo alloc] initWithTitle:@"Walk Dog" andDescription:@"Walk The Dog" andPriority:@6];
    Todo *todo5 = [[Todo alloc] initWithTitle:@"Eat Dinner" andDescription:@"Eat Dinner" andPriority:@2];
    Todo *todo6 = [[Todo alloc] initWithTitle:@"Phone Call" andDescription:@"Make Phone Call" andPriority:@1];
    [todo6 setIsCompleted:YES];
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:@[todo1,todo2,todo3,todo4,todo5,todo6]];
    
    self.objects = objects;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self performSegueWithIdentifier:@"createNewTodo" sender:self];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    } else if ([[segue identifier] isEqualToString:@"createNewTodo"]) {
        [[segue destinationViewController] setTodoDelegate:self];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setATodo:self.objects[indexPath.row]];
    return cell;
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
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark -SwipeGestureRecognizer

- (IBAction)swipeToSetAsCompleted:(UISwipeGestureRecognizer *)sender {
    CGPoint point = [self.swipeGestureRecognizer locationInView:self.view];
    TodoTableViewCell *swipedCell = [self.view hitTest:point withEvent:nil];
    [swipedCell updateTodoCompletion:YES];

}

#pragma mark - TodoCreationProtocal

- (void)transferTodo:(Todo *)aTodo {
    [self.objects insertObject:aTodo atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}

@end
