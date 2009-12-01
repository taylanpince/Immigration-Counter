//
//  MainViewController.m
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright Hippo Foundry 2009. All rights reserved.
//

#import "ImmigrationCounterAppDelegate.h"
#import "MainViewController.h"
#import "MainView.h"
#import "Event.h"


@implementation MainViewController

@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
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
	
	NSInteger totalDays = 0;
	
	for (NSInteger i = 0; i < [results count]; i++) {
		totalDays += [(Event *)[results objectAtIndex:i] differenceBetweenDatesInDays];
	}
	
	NSLog(@"TOTAL DAYS ON VACATION: %D", totalDays);
	
	[results release];
	[request release];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDate *savedDate = (NSDate *)[defaults objectForKey:@"immigrationDate"];
	
	if (savedDate) {
		NSTimeInterval immigrationTime = 3 * 365 * 24 * 60 * 60;
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:[NSDate date] toDate:[savedDate addTimeInterval:immigrationTime] options:0];
		
		NSLog(@"DAYS UNTIL IMMIGRATION: %D", [components day]);
		NSLog(@"TOTAL DAYS: %D", [components day] + totalDays);
	}
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo {
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
	
	[controller setDelegate:self];
	[navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self presentModalViewController:navController animated:YES];
	
	[controller release];
	[navController release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	
}

- (void)dealloc {
	[managedObjectContext release];
    [super dealloc];
}

@end