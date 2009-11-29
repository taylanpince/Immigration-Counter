//
//  FlipsideViewController.m
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright Hippo Foundry 2009. All rights reserved.
//

#import "ImmigrationCounterAppDelegate.h"
#import "FlipsideViewController.h"
#import "AddEditEventViewController.h"
#import "Event.h"


@implementation FlipsideViewController

@synthesize delegate, eventsArray, managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setTitle:@"Settings"];
	[[self navigationController] setNavigationBarHidden:NO];
	
	[[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
	
	UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	[[self navigationItem] setRightBarButtonItem:saveBarButtonItem];
	[saveBarButtonItem release];
	
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

- (void)save {
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
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		/*DataSetViewController *controller = [[DataSetViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		controller.dataSet = dataSet;
		
		[self.navigationController pushViewController:controller animated:YES];
		
		[controller release];*/
	} else {
		/*DataPanel *dataPanel;
		
		if (indexPath.row == [eventsArray count]) {
			dataPanel = [[[DataPanel alloc] init] autorelease];
		} else {
			dataPanel = [[(MagpieAppDelegate *)[[UIApplication sharedApplication] delegate] dataPanels] objectAtIndex:indexPath.row];
		}*/
		
		AddEditEventViewController *controller = [[AddEditEventViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		//controller.dataPanel = dataPanel;
		
		[self.navigationController pushViewController:controller animated:YES];
		
		[controller release];
	}
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return UITableViewCellEditingStyleInsert;
	} else {
		if (indexPath.row == [eventsArray count]) {
			return UITableViewCellEditingStyleInsert;
		} else {
			return UITableViewCellEditingStyleDelete;
		}
	}
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSManagedObject *event = [eventsArray objectAtIndex:indexPath.row];
		
		[managedObjectContext deleteObject:event];
		[eventsArray removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		
		NSError *error;
		
		if (![managedObjectContext save:&error]) {
			// TODO: Handle the error
		}
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
		[self tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
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