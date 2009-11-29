//
//  AddEditEventViewController.h
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//


@interface AddEditEventViewController : UITableViewController {
	UIDatePicker *datePicker;
}

@property (nonatomic, retain) UIDatePicker *datePicker;

- (void)save;

@end