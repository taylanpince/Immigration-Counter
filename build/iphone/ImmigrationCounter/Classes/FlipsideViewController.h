//
//  FlipsideViewController.h
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright Hippo Foundry 2009. All rights reserved.
//

#import "AddEditEventViewController.h"
#import "AddEditDateViewController.h"


@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UITableViewController <AddEditEventViewControllerDelegate, AddEditDateViewControllerDelegate> {
	NSMutableArray *eventsArray;
	NSManagedObjectContext *managedObjectContext;
	NSDateFormatter *dateFormatter;
	NSDate *immigrationDate;
	
	id <FlipsideViewControllerDelegate> delegate;
}

@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSDate *immigrationDate;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (void)save;

@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

