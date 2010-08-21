//
//  Recipient.m
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright 2010 pubhttp.com. All rights reserved.
//

#import "Recipient.h"


@implementation Recipient
@synthesize companyId,companyName,totalAmount,totalJobs,logitude,latitude,primaryAgency;

-(id) init{
	
 if (self = [super init]) {
	
 }	
	return self;
	
}

- (id) initWithCompnayId:(NSString *) _companyId companyName:(NSString *) _companyName totalAmount:(NSNumber *) _totalAmount
			   totaljobs: (NSNumber *)_totaljobs logitude:(NSNumber *) _logitude latitude:(NSNumber *) _latitude primaryAgency:(NSString *)_primaryAgency{
    if (self= [super init]) {
		
	self.companyId=_companyId;
	self.companyName=_companyName;
	self.totalAmount=_totalAmount;
	self.totalJobs=_totaljobs;
	self.latitude=_latitude;
	self.logitude=_logitude;
	self.primaryAgency=_primaryAgency;
			}
	return self;
}

@end
