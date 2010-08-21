//
//  AwardData.h
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AwardData : NSObject {
	NSString *awardID;
	NSString *CompanyName;
	double amount;
	NSString *agencyID;
	int jobs;
	double longitude;
	double latitude;
}

@property (nonatomic,copy) NSString *awardID;
@property (nonatomic,copy) NSString *CompanyName;
@property (nonatomic,copy) NSString *agencyID;
@property (nonatomic,assign) double amount;
@property (nonatomic,assign) double longitude;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) int jobs;

@end
