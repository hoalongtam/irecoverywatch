//
//  mapViewController.m
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import "MapViewController.h"
#import "Recipient.h"
#import "iRecoveryWatchAppDelegate.h"

@implementation MapViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES; //(interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
	//mapView = (MKMapView*)self.view;

	[mapView setZoomEnabled:YES];
	[mapView setMapType:MKMapTypeStandard];
    [mapView setScrollEnabled:YES];
    [mapView setShowsUserLocation:YES];
		
	mapView.delegate=self;	
	
	//cLoc = [[CurrentLoc alloc]init];
	
	[self showMap];
}

- (void) viewDidAppear:(BOOL)animated {
	
	NSLog(@"stop here");
	iRecoveryWatchAppDelegate *delegate = (iRecoveryWatchAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self doAnnotations:delegate.recipientArray];
	/*
	NSMutableArray *array = [[NSMutableArray alloc] init];

	AwardData *newEntry = [[AwardData alloc] init];
	// Set Values
	
	newEntry.CompanyName = @"ABC";
	newEntry.jobs = 23;
	newEntry.amount = 12345.46;
	newEntry.latitude = 37.37688;
	newEntry.longitude =  -121.9214;

	// Add the AwardData object to the array
	[array addObject:newEntry];
	[newEntry release];

	newEntry = [[AwardData alloc] init];
	// Set Values
	newEntry.CompanyName = @"XYZ";
	newEntry.jobs = 43;
	newEntry.amount = 34576.24;
	newEntry.latitude = 37.47688;
	newEntry.longitude =  -121.6214;
	
	// Add the AwardData object to the array
	[array addObject:newEntry];
	[newEntry release];
	
	[self doAnnotations:array];
	[self doOverlays:array];
	[array release];
	 */
}


- (MKOverlayView *)mapView:(MKMapView *)mapViewx viewForOverlay:(id <MKOverlay>)overlay
{
	MKOverlayView *ovlView = nil;
	
	/* 
	if (overlay == mapViewx.userLocation)
	{
		[mapView setCenterCoordinate:mapView.userLocation.coordinate animated:TRUE];
		// We can return nil to let the MapView handle the default annotation view (blue dot):
		return nil;
		
		// Or instead, we can create our own blue dot and even configure it:
		//annView = (MKPinAnnotationView*)[mapViewx dequeueReusableAnnotationViewWithIdentifier:@"blueDot"];
		//if (annView != nil)
		{
			//	annView.annotation = annotation;
		}
		//else
		{
			//	annView = (MKPinAnnotationView*)[[[NSClassFromString(@"MKUserLocationView") alloc] initWithAnnotation:annotation reuseIdentifier:@"blueDot"] autorelease];
			
			// Optionally configure the MKUserLocationView object here
			// Google MKUserLocationView for the options
		}
	}
	else
	{
		// The requested annotation view is for another annotation than the userLocation.
		// Let's return a normal pin:
		annView = (MKPinAnnotationView*)[mapViewx dequeueReusableAnnotationViewWithIdentifier:[annotation title]];
		
		if (annView != nil)
		{
			annView.annotation = annotation;
		}
		else
		{
			annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[annotation title]] autorelease];
			annView.pinColor = MKPinAnnotationColorGreen;
			
			annView.canShowCallout = TRUE;
		}
		
	}
	*/
	
	return ovlView;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapViewx viewForAnnotation:(id <MKAnnotation>) annotation
{
	MKPinAnnotationView *annView; //=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	
	if (annotation == mapViewx.userLocation)
	{
		[mapView setCenterCoordinate:mapView.userLocation.coordinate animated:TRUE];
		// We can return nil to let the MapView handle the default annotation view (blue dot):
		return nil;
		
		// Or instead, we can create our own blue dot and even configure it:
		//annView = (MKPinAnnotationView*)[mapViewx dequeueReusableAnnotationViewWithIdentifier:@"blueDot"];
		//if (annView != nil)
		{
			//	annView.annotation = annotation;
		}
		//else
		{
			//	annView = (MKPinAnnotationView*)[[[NSClassFromString(@"MKUserLocationView") alloc] initWithAnnotation:annotation reuseIdentifier:@"blueDot"] autorelease];
			
			// Optionally configure the MKUserLocationView object here
			// Google MKUserLocationView for the options
		}
	}
	else
	{
		// The requested annotation view is for another annotation than the userLocation.
		// Let's return a normal pin:
		annView = (MKPinAnnotationView*)[mapViewx dequeueReusableAnnotationViewWithIdentifier:[annotation title]];
		
		if (annView != nil)
		{
			annView.annotation = annotation;
		}
		else
		{
			annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[annotation title]] autorelease];
			annView.pinColor = MKPinAnnotationColorGreen;
			
			//UITableView *detView = [[UITableView alloc] init];
			//annView.rightCalloutAccessoryView = detView;
			
			UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			[button addTarget:self 
					   action:@selector(infoButton:)
			forControlEvents:UIControlEventTouchDown];
			annView.rightCalloutAccessoryView = button;
			
			//UIImage *agency = [[UIImage alloc]initWithContentsOfFile:@"/Work/iPhoneTouchPad/iOSDevCamp/irecoverywatch/iPhone/agency.png"];
			UIImage *agency = [UIImage imageNamed:@"agency.png"];
			
			UIImageView *agencyImageView = [[UIImageView alloc] initWithImage:agency];
			annView.leftCalloutAccessoryView = agencyImageView;
			[agencyImageView release];
			//[agency release];
			annView.canShowCallout = TRUE;
		}
	}
	
	annView.animatesDrop=TRUE;
	return annView;
}

- (void)infoButton:(id)sender {
	DetailViewCompanyController *detailView = [[DetailViewCompanyController alloc] init];
	
	[[self navigationController] pushViewController:detailView animated:YES];
	
	[detailView release];
}

- (void)doOverlays:(NSMutableArray *)recoveryData {
	NSMutableArray *overlayList = [[NSMutableArray alloc] init];
	// create loop here if necessary
	for (AwardData *entryToAnnotate in recoveryData) {
		OverlayListObjects *newOverlay = [OverlayListObjects new];
		CLLocationCoordinate2D tempCoordinate;
		tempCoordinate.latitude = entryToAnnotate.latitude;  // set latitude to required value
		tempCoordinate.longitude =  entryToAnnotate.longitude; // set longitude to required value
		//[newOverlay setCoordinate: tempCoordinate];
		//[newOverlay setTitle: entryToAnnotate.CompanyName]; // or whatever
		//[newOverlay setSubtitle: [NSString stringWithFormat:@"%f", entryToAnnotate.amount]]; // or whatever
		//MKMapRect rect = MKMapRectMake(0, 0, 100, 100);
		//[newOverlay setBoundingMapRect:MKMapRectMake(0, 0, 100, 100)];
		[overlayList addObject: newOverlay];
		[newOverlay release];
	}
	// end loop here if looped
	[mapView addOverlays: overlayList];
	
	[overlayList release];
}

- (void)mapView:(MKMapView *)mapViewx didAddOverlayViews:(NSArray *)overlayViews {
	NSLog(@"Overlays: %@", [overlayViews count]);
}

- (void)doAnnotations:(NSMutableArray *)recoveryData {
	NSMutableArray *annotationList = [[NSMutableArray alloc] init];
	NSLog(@"doAnnotations recoveryData count = %d",[recoveryData count]);
	for (Recipient *recipient in recoveryData) {
		
		NSLog(@"latitude %f",[[recipient latitude] floatValue]);
		NSLog(@"logitude %f",[[recipient logitude] floatValue]);
		
		
		AnnotationListObject *newAnnotation = [AnnotationListObject new];
		
		CLLocationCoordinate2D tempCoordinate;
		tempCoordinate.latitude =[[recipient latitude] floatValue];  // set latitude to required value
		tempCoordinate.longitude =  [[recipient logitude] floatValue];  // set longitude to required value
		
		[newAnnotation setCoordinate: tempCoordinate];
		[newAnnotation setTitle: [recipient companyName]]; // or whatever
		NSLog(@"Company name %@",[recipient companyName]);
		[newAnnotation setSubtitle: [NSString stringWithFormat:@"%f", [recipient totalAmount]]]; // or whatever
		[annotationList addObject: newAnnotation];
		[newAnnotation release];
	}
	// create loop here if necessary
	/*
	for (AwardData *entryToAnnotate in recoveryData) {
		AnnotationListObject *newAnnotation = [AnnotationListObject new];
		CLLocationCoordinate2D tempCoordinate;
		tempCoordinate.latitude = entryToAnnotate.latitude;  // set latitude to required value
		tempCoordinate.longitude =  entryToAnnotate.longitude; // set longitude to required value
		[newAnnotation setCoordinate: tempCoordinate];
		[newAnnotation setTitle: entryToAnnotate.CompanyName]; // or whatever
		[newAnnotation setSubtitle: [NSString stringWithFormat:@"%f", entryToAnnotate.amount]]; // or whatever
		[annotationList addObject: newAnnotation];
		[newAnnotation release];
	}*/
	// end loop here if looped
	[mapView addAnnotations: annotationList];
	
	[annotationList release];
}

- (void)dealloc {
    [super dealloc];
}

- (void)showMap
{
	CLLocation *userLoc = mapView.userLocation.location;
    CLLocationCoordinate2D userCoordinate = userLoc.coordinate;
	
	//NSLog(@"user latitude = %f",userCoordinate.latitude);
	//NSLog(@"user longitude = %f",userCoordinate.longitude);
	
	userCoordinate.latitude  = 37.37688;
	userCoordinate.longitude = -121.9214;
	
	mapView.region = MKCoordinateRegionMakeWithDistance(userCoordinate, 2000, 2000); 
	
	/*
	// Region and Zoom
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta  = 2.0;
	span.longitudeDelta = 2.0;
	
	CLLocationCoordinate2D location = mapView.userLocation.coordinate;
	
	// Home LA 34.2206,-118.5488
	location.latitude  =  34.1709;
	location.longitude = -118.5714;
	region.span   = span;
	region.center = location;
	
	// Geocoder Stuff
	geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:location];
	geoCoder.delegate = self;
	[geoCoder start];
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	[mapView setCenterCoordinate:location animated:TRUE];
	*/
}


- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
	NSLog(@"Reverse Geocoder Errored");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
	NSLog(@"Reverse Geocoder completed");
//	mPlacemark=placemark;
//	[mapView addAnnotation:placemark];
}

@end
