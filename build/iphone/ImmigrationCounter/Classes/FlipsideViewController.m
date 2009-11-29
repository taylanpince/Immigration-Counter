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
	
	[self setTitle:@"Settings"];
	[[self navigationController] setNavigationBarHidden:NO];
	
	UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
	[[self navigationItem] setLeftBarButtonItem:doneBarButtonItem];
	[doneBarButtonItem release];
	
	[self setManagedObjectContext:[(ImmigrationCounterAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];
	NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
	NSArray *sorters = [[NSArray alloc] initWithObjects:sorter, nil];
	
	[request setEntity:entity];
	[request setSortDescriptors:sorters];
	
	[sorter release];
	[sorters release];
	
	NSError *error;
	NSMutableArray *results = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	if (results == nil) {
		// TODO: Handle the error
	}
	
	[self setEventsArray:results];
	[results release];
	[request release];
}

- (void)done {
	[[self delegate] flipsideViewControllerDidFinish:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (section == 0) ? 1 : [eventsArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	
	if (indexPath.section == 0) {
		[[cell textLabel] setText:@"18/08/2008"];
	} else {
		if (indexPath.row == [eventsArray count]) {
			[[cell textLabel] setText:@"Add a new vacation"];
		} else {
			[[cell textLabel] setText:@"01/02/2009 - 10/02/2009"];
			[[cell detailTextLabel] setText:@"9 days"];
		}
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return (section == 0) ? @"Start Date" : @"Vacations";
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