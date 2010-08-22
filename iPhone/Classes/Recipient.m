//
//  Recipient.m
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright 2010 pubhttp.com. All rights reserved.
//

#import "Recipient.h"


@implementation Recipient
@synthesize companyId,companyName,totalAmount,totalJobs,logitude,latitude,primaryAgency,awardKey;

-(id) init{
	
 if (self = [super init]) {
	
 }	
	return self;
	
}

- (id) initWithCompnayId:(NSNumber *) _companyId companyName:(NSString *) _companyName totalAmount:(NSNumber *) _totalAmount
			   totaljobs: (NSNumber *)_totaljobs logitude:(NSNumber *) _logitude latitude:(NSNumber *) _latitude primaryAgency:(NSString *)_primaryAgency  awardKey:(NSString *)_awardKey{
    if (self= [super init]) {
		
	self.companyId=_companyId;
	self.companyName=_companyName;
	self.totalAmount=_totalAmount;
	self.totalJobs=_totaljobs;
	self.latitude=_latitude;
	self.logitude=_logitude;
	self.primaryAgency=_primaryAgency;
		self.awardKey=_awardKey;
			}
	return self;
}

@end
