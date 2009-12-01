//
//  AddEditDateViewController.h
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-30.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

@protocol AddEditDateViewControllerDelegate;

@interface AddEditDateViewController : UITableViewController {
	UIDatePicker *datePicker;
	NSDateFormatter *dateFormatter;
	NSDate *immigrationDate;
	
	id <AddEditDateViewControllerDelegate> delegate;
}

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSDate *immigrationDate;

@property (nonatomic, assign) id <AddEditDateViewControllerDelegate> delegate;

- (void)save;
- (void)cancel;

@end

@protocol AddEditDateViewControllerDelegate
- (void)addEditDateViewController:(AddEditDateViewController *)controller didFinishWithSave:(BOOL)save;
@end
