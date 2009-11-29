//
//  Event.h
//  ImmigrationCounter
//
//  Created by Taylan Pince on 09-11-29.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//


@interface Event : NSManagedObject {
	
}

@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSDate *startDate;

@end