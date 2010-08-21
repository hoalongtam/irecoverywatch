//
//  mapViewController.h
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "AnnotationListObject.h"
#import "AwardData.h"

@class AwardData;

@interface MapViewController : UIViewController <MKReverseGeocoderDelegate, MKMapViewDelegate> {
	MKMapView			*mapView;
	MKReverseGeocoder	*geoCoder;
}

- (void)showMap;
- (void)doAnnotations:(NSMutableArray *)recoveryData;

@end
