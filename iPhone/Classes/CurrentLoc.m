//
//  CurrentLoc.m
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import "CurrentLoc.h"


@implementation CurrentLoc

@synthesize locationManager;

- (id)init {
	self = [super init];
    if (self != nil) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self; // send loc updates to myself
	
		self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
		[self.locationManager startUpdatingLocation];
    }
	
	return self;
}

/*
- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation {
	
	CLLocationCoordinate2D userCoordinate = newLocation.coordinate;
	NSLog(@"new latitude  = %f",userCoordinate.latitude);
	NSLog(@"new longitude = %f",userCoordinate.longitude);
} 
*/

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

- (void)dealloc {
    [self.locationManager release];
    [super dealloc];
}

@end
