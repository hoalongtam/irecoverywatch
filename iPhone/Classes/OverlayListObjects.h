//
//  OverlayListObjects.h
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface OverlayListObjects : NSObject <MKOverlay>{
	MKMapRect boundingMapRect;
	CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) MKMapRect boundingMapRect;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
