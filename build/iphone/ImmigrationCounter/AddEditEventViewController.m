//
//  AddEditEventViewController.m
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "AddEditEventViewController.h"
#import "Event.h"


@implementation AddEditEventViewController

@synthesize datePicker, activeSection, dateFormatter, event, delegate, insert;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (self.insert) {
		[self setTitle:@"Add Vacation"];
	} else {
		[self setTitle:@"Edit Vacation"];
	}
	
	[self.tableView setScrollEnabled:NO];
	
	UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	[[self navigationItem] setLeftBarButtonItem:cancelBarButtonItem];
	[cancelBarButtonItem release];
	
	UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	[saveBarButtonItem setEnabled:NO];
	[[self navigationItem] setRightBarButtonItem:saveBarButtonItem];
	[saveBarButtonItem release];
	
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 200.0, self.view.frame.size.width, 216.0)];
	
	[datePicker setDatePickerMode:UIDatePickerModeDate];
	[datePicker addTarget:self action:@selector(didSelectDate:) forControlEvents:UIControlEventValueChanged];
	
	[self.view addSubview:datePicker];
	[self setActiveSection:0];
	
	[self setDateFormatter:[[NSDateFormatter alloc] init]];
	[[self dateFormatter] setDateStyle:NSDateFormatterLongStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	
}

- (void)save {
	[[self delegate] addEditEventViewController:self didFinishWithSave:YES withInsert:self.insert];
}

- (void)cancel {
	[[self delegate] addEditEventViewController:self didFinishWithSave:NO withInsert:self.insert];
}

- (void)didSelectDate:(id)sender {
	if (activeSection == 0) {
		[event setStartDate:[datePicker date]];
	} else {
		[event setEndDate:[datePicker date]];
	}
	
	[[[self navigationItem] rightBarButtonItem] setEnabled:([event startDate] && [event endDate])];
	[[self tableView] reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return (section == 0) ? @"Start Date" : @"End Date";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if (indexPath.section == 0) {
		[[cell textLabel] setText:[dateFormatter stringFromDate:[event startDate]]];
	} else {
		[[cell textLabel] setText:[dateFormatter stringFromDate:[event endDate]]];
	}
	
	if (indexPath.section == activeSection) {
		[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self setActiveSection:indexPath.section];
}

- (void)dealloc {
	[datePicker release];
	[dateFormatter release];
	[event release];
    [super dealloc];
}

@end