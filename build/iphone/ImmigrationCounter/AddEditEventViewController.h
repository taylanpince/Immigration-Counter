//
//  AddEditEventViewController.h
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "Event.h"


@protocol AddEditEventViewControllerDelegate;

@interface AddEditEventViewController : UITableViewController {
	UIDatePicker *datePicker;
	NSDateFormatter *dateFormatter;
	NSUInteger activeSection;
	BOOL insert;
	
	id <AddEditEventViewControllerDelegate> delegate;
	
	Event *event;
}

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, assign) NSUInteger activeSection;
@property (nonatomic, retain) Event *event;
@property (nonatomic, assign, setter=setInsert) BOOL insert;

@property (nonatomic, assign) id <AddEditEventViewControllerDelegate> delegate;

- (void)save;
- (void)cancel;

@end

@protocol AddEditEventViewControllerDelegate
- (void)addEditEventViewController:(AddEditEventViewController *)controller didFinishWithSave:(BOOL)save withInsert:(BOOL)insert;
@end