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
}

@property (nonatomic, retain) CLLocationManager *locationManager;

@end
