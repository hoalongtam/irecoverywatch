//
//  iRecoveryWatchAppDelegate.h
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright pubhttp.com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "TickerViewController.h";
#import  "TagsViewController.h";
#import  "MapViewController.h";
#import  "ListViewController.h";
#import  "SettingsViewController.h";
#import  "CurrentLoc.h";



@interface iRecoveryWatchAppDelegate : NSObject <UIApplicationDelegate> {
 
	UIWindow *window;
	
	// AllViewControllers
	UITabBarController *tabBarController;
    
	TagsViewController *tagsViewController;
	MapViewController *mapViewController;
	ListViewController *listViewController;
	SettingsViewController *settingsViewController;
	
	UINavigationController *tagsViewNavController; 
	
	//Data
	
	
	NSMutableArray *recipientArray;
	CurrentLoc *currentLocation;
	
	
	
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) UITabBarController *tabBarController;

@property (nonatomic, retain) TagsViewController *tagsViewController;
@property (nonatomic, retain) MapViewController *mapViewController;
@property (nonatomic, retain) ListViewController *listViewController;
@property (nonatomic, retain) SettingsViewController *settingsViewController;

@property (nonatomic, retain) NSMutableArray *recipientArray;
@property (nonatomic, retain) CurrentLoc *currentLocation;



-(void) getJSONData:(NSString *) _queryString urlDelegate:(id)_delegate;

-(NSMutableArray *) getRecipientsData:(NSMutableData *) _responseData;

@end

