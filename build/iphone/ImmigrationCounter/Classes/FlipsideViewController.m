//
//  FlipsideViewController.m
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright Hippo Foundry 2009. All rights reserved.
//

#import "ImmigrationCounterAppDelegate.h"
#import "FlipsideViewController.h"
#import "Event.h"


@implementation FlipsideViewController

@synthesize delegate, eventsArray, managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setTitle:@"Events"];
	[[self navigationController] setNavigationBarHidden:NO];
	//[[self view] setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
	
	UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
	[[self navigationItem] setLeftBarButtonItem:doneBarButtonItem];
	[doneBarButtonItem release];
	
	[self setManagedObjectContext:[(ImmigrationCounterAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
}

- (void)done {
	[[self delegate] flipsideViewControllerDidFinish:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Test";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	eventsArray = nil;
}

- (void)dealloc {
	[eventsArray release];
	[managedObjectContext release];
    [super dealloc];
}

@end