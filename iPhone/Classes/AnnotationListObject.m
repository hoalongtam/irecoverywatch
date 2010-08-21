//
//  AnnotationListObject.m
//  MapKit1
//
//  Created by Danthac on 9/13/09.
//  Copyright 2009 dandil. All rights reserved.
//

#import "AnnotationListObject.h"


@implementation AnnotationListObject

@synthesize coordinate, title, subtitle;

- (void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate {
	coordinate = newCoordinate;
}

@end



