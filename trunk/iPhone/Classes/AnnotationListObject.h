//
//  AnnotationListObject.h
//  MapKit1
//
//  Created by Danthac on 9/13/09.
//  Copyright 2009 dandil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AnnotationListObject : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
	NSString *key;
}
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *key;

- (void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate;
@end

