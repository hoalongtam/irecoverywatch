//
//  mapViewController.h
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "DetailViewCompanyController.h"
#import "AnnotationListObject.h"
#import "OverlayListObjects.h"
#import "AwardData.h"

#import "CurrentLoc.h"

@class AwardData;

@interface MapViewController : UIViewController <MKReverseGeocoderDelegate, MKMapViewDelegate> {
	IBOutlet MKMapView	 *mapView;
	
	MKReverseGeocoder	*geoCoder;
	CurrentLoc			*cLoc;
}

- (void)infoButton:(id)sender;
- (void)showMap;
- (void)doAnnotations:(NSMutableArray *)recoveryData;
- (void)doOverlays:(NSMutableArray *)recoveryData;

@end
