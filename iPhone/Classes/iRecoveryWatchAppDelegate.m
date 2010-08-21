//
//  iRecoveryWatchAppDelegate.m
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright pubhttp.com 2010. All rights reserved.
//

#import "iRecoveryWatchAppDelegate.h"
#import "TickerViewController.h"
#import "TagsViewController.h"
#import "MapViewController.h"
#import "ListViewController.h"
#import "SettingsViewController.h"



@implementation iRecoveryWatchAppDelegate

@synthesize window;
@synthesize tabBarController,tickerViewController,tagsViewController,mapViewController,listViewController,tickerViewNavController,settingsViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	
	//create tab bar controller
	tabBarController = [[UITabBarController alloc] init];

	
	//======================= TickerView ==============================================
    tickerViewController = [[TickerViewController alloc] init];
	tickerViewController.title=@"Ticker";
	//tickerViewController.tabBarItem.image = [UIImage imageNamed:@"faves.png"];
   // tickerViewController.view.backgroundColor = [UIColor redColor];
    
	//Create UINavigationController for tickerView
	tickerViewNavController= [[UINavigationController alloc]initWithRootViewController:tickerViewController];
	
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(location)];
	tickerViewController.navigationItem.rightBarButtonItem=barButton;
    //======================= TagsView ==============================================
    tagsViewController = [[TickerViewController alloc] init];
	tagsViewController.title=@"Tags";
	//tagsViewController.tabBarItem.image = [UIImage imageNamed:@"faves.png"];
    //tagsViewController.view.backgroundColor = [UIColor redColor];
    
	//Create UINavigationController for tickerView
	UINavigationController	*tagsViewNavController= [[UINavigationController alloc]initWithRootViewController:tagsViewController];
	
	//======================= MapsView ==============================================
    mapViewController = [[MapViewController alloc] init];
	mapViewController.title=@"Map";
	//mapViewController.tabBarItem.image = [UIImage imageNamed:@"faves.png"];
    //mapViewController.view.backgroundColor = [UIColor redColor];
    
	//Create UINavigationController for tickerView
	UINavigationController	*mapViewNavController= [[UINavigationController alloc]initWithRootViewController:mapViewController];
	
	//======================= ListView ==============================================
    listViewController = [[ListViewController alloc] init];
	listViewController.title=@"List";
	//listViewController.tabBarItem.image = [UIImage imageNamed:@"faves.png"];
    //listViewController.view.backgroundColor = [UIColor redColor];
    
	//Create UINavigationController for tickerView
	UINavigationController	*listViewNavController= [[UINavigationController alloc]initWithRootViewController:listViewController];
	
	
	// Add all the view controllers as children of the tab bar controller
    tabBarController.viewControllers = [NSArray arrayWithObjects:tickerViewNavController,tagsViewNavController,mapViewNavController,listViewNavController, nil];

	
	//Memory management for locally created objects..
	[tickerViewController release];
	[tagsViewController release];
	[mapViewController release];
	[listViewController release];
	[tagsViewNavController release];
	[tickerViewNavController release];
	[mapViewNavController release];
	[listViewNavController release];
	
    [window addSubview:tabBarController.view];
	
    [window makeKeyAndVisible];

    return YES;
}

-(void) location{
	settingsViewController= [[SettingsViewController alloc]init];
	[tickerViewNavController pushViewController:settingsViewController animated:YES];
	[settingsViewController release];
	/*
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Bar button Message" message:@"implement location" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];		
	 [alertView show];
	 [alertView release];
	 */
	 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	
	[tickerViewController release];
	[tagsViewController release];
	[mapViewController release];
	[listViewController release];
	[tickerViewNavController release];
	[settingsViewController release];
    [window release];
    [super dealloc];
}


@end
