// 
//  Event.m
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "Event.h"


@implementation Event 

@dynamic endDate;
@dynamic startDate;

- (NSInteger)differenceBetweenDatesInDays {
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:[self startDate] toDate:[self endDate] options:0];
	
	return [components day] + 1;
}

- (BOOL)datesAreValid {
	NSComparisonResult comparison = [[self startDate] compare:[self endDate]];
	
	return (comparison == NSOrderedSame | comparison == NSOrderedAscending);
}

@end