//
//  LocationViewController.h
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright 2010 pubhttp.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LocationViewController : UIViewController {
	IBOutlet UILabel * milesLabel;
	IBOutlet UILabel * milesLabels;
	
}
@property (nonatomic,retain) UILabel *milesLabel;
-(IBAction) locationChanged:(id)sender;

@end
