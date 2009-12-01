//
//  AddEditDateViewController.m
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-30.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "AddEditDateViewController.h"


@implementation AddEditDateViewController

@synthesize datePicker, dateFormatter, immigrationDate, delegate;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setTitle:@"Edit Start Date"];
	[self.tableView setScrollEnabled:NO];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDate *savedDate = (NSDate *)[defaults objectForKey:@"immigrationDate"];
	
	if (savedDate) {
		[self setImmigrationDate:savedDate];
	}
	
	UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	[[self navigationItem] setLeftBarButtonItem:cancelBarButtonItem];
	[cancelBarButtonItem release];
	
	UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	[saveBarButtonItem setEnabled:(immigrationDate != nil)];
	[[self navigationItem] setRightBarButtonItem:saveBarButtonItem];
	[saveBarButtonItem release];
	
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 200.0, self.view.frame.size.width, 216.0)];
	
	[datePicker setDatePickerMode:UIDatePickerModeDate];
	[datePicker addTarget:self action:@selector(didSelectDate:) forControlEvents:UIControlEventValueChanged];
	
	if ([self immigrationDate]) {
		[datePicker setDate:[self immigrationDate]];
	}
	
	[self.view addSubview:datePicker];
	
	[self setDateFormatter:[[NSDateFormatter alloc] init]];
	[[self dateFormatter] setDateStyle:NSDateFormatterLongStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	
}

- (void)save {
	[[self delegate] addEditDateViewController:self didFinishWithSave:YES];
}

- (void)cancel {
	[[self delegate] addEditDateViewController:self didFinishWithSave:NO];
}

- (void)didSelectDate:(id)sender {
	[self setImmigrationDate:[datePicker date]];
	[[[self navigationItem] rightBarButtonItem] setEnabled:YES];
	[[self tableView] reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Start Date";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if (immigrationDate) {
		[[cell textLabel] setText:[dateFormatter stringFromDate:immigrationDate]];
	} else {
		[[cell textLabel] setText:@"N/A"];
	}
	
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[datePicker setDate:[self immigrationDate]];
}

- (void)dealloc {
	[datePicker release];
	[dateFormatter release];
	[immigrationDate release];
    [super dealloc];
}

@end