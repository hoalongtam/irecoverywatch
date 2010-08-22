//
//  Recipient.h
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright 2010 pubhttp.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Recipient : NSObject {
	
	NSNumber *companyId;
	NSString *companyName;
	NSNumber *totalAmount;
	NSNumber *totalJobs;
	NSNumber *logitude;
	NSNumber *latitude;
	NSString *primaryAgency;

}
@property (nonatomic,retain) NSNumber *companyId;
@property (nonatomic,retain) NSString *companyName;
@property (nonatomic,retain) NSNumber *totalAmount;
@property (nonatomic,retain) NSNumber *totalJobs;
@property (nonatomic,retain) NSNumber *logitude;
@property (nonatomic,retain) NSNumber *latitude;
@property (nonatomic,retain) NSString *primaryAgency;

- (id) initWithCompnayId:(NSNumber *) _companyId companyName:(NSString *) _companyName totalAmount:(NSNumber *) _totalAmount
			   totaljobs: (NSNumber *)_totaljobs logitude:(NSNumber *) _logitude latitude:(NSNumber *) _latitude primaryAgency:(NSString *)_primaryAgency;
 
@end
