//
//  CurrentLoc.h
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CurrentLoc : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	double latitude;
	double longitude;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property  double latitude;
@property double longitude;

- (id) initWithLongitude: (double) _long latitude:(double) _lat;

- (id) initWithLongitude: (double) _long latitude:(double) _lat delegate:(id)_delegate;

@end
