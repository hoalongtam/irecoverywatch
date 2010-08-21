//
//  SettingsViewController.h
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright 2010 pubhttp.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {
	
	UILabel *distance;

}
@property (nonatomic,retain) IBOutlet UILabel *distance;
-(IBAction) distanceChanged:(id) sender;
@end
