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
#import "TodoTableEntries.h"

@interface MasterViewController () <UITableViewDelegate, TodoCreationProtocol>

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGestureRecognizer;

@property (weak, nonatomic) IBOutlet UISegmentedControl *todoOrderSegmentedControl;

@property TodoTableEntries *tableEntries;

@property Todo *selectedTodo;


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
    
    self.tableEntries = [[TodoTableEntries alloc] init];
    [self.tableEntries setViewController:self];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    [self performSegueWithIdentifier:@"createNewTodo" sender:self];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        [[segue destinationViewController] setDetailItem:self.selectedTodo];
    } else if ([[segue identifier] isEqualToString:@"createNewTodo"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableEntries.todoDictionary.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableEntries.todoDictionary.allValues[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.tableEntries getTitleForHeaderInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TodoCell"];
    [cell setATodo:self.tableEntries.todoDictionary.allValues[indexPath.section][indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedTodo = self.tableEntries.todoDictionary.allValues[indexPath.section][indexPath.row];
     [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - TodoCreationProtocal

- (void)saveTodo {
    // refresh the list....
    [self.tableEntries save];
}

#pragma mark - SwipeGestureRecognizer

- (IBAction)swipeToSetAsCompleted:(UISwipeGestureRecognizer *)sender {
    CGPoint point = [self.swipeGestureRecognizer locationInView:self.view];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    Todo *aTodo = self.tableEntries.todoDictionary.allValues[indexPath.section][indexPath.row];
    aTodo.completed = true;
    
    [self.tableEntries save];
}

#pragma mark - Segmented Control


// I guess we would want to change the sort descriptors that we are using here, perhaps update


- (IBAction)orderAccordingToControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.tableEntries sortDictionaryByPriority];
    } else if (sender.selectedSegmentIndex == 1) {
        [self.tableEntries sortDictionaryByDeadline];
    }
}


@end