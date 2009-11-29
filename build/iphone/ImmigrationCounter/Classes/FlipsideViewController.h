//
//  FlipsideViewController.h
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright Hippo Foundry 2009. All rights reserved.
//

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UITableViewController {
	NSMutableArray *eventsArray;
	NSManagedObjectContext *managedObjectContext;
	
	id <FlipsideViewControllerDelegate> delegate;
}

@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (void)save;

@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

