//
//  AddEditEventViewController.m
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "AddEditEventViewController.h"


@implementation AddEditEventViewController

@synthesize datePicker;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setTitle:@"Add Vacation"];
	[self.tableView setScrollEnabled:NO];
	
	UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	[[self navigationItem] setRightBarButtonItem:saveBarButtonItem];
	[saveBarButtonItem release];
	
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 200.0, self.view.frame.size.width, 216.0)];
	
	[datePicker setDatePickerMode:UIDatePickerModeDate];
	[datePicker addTarget:self action:@selector(didSelectDate:) forControlEvents:UIControlEventValueChanged];
	
	[self.view addSubview:datePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	
}

- (void)save {
	
}

- (void)didSelectDate:(id)sender {
	[self.tableView reloadData];
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
		
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
	
    return cell;
}

- (void)dealloc {
    [super dealloc];
}

@end