//
//  iRecoveryWatchAppDelegate.m
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright pubhttp.com 2010. All rights reserved.
//

#import "iRecoveryWatchAppDelegate.h"
#import "JSON.h"
#import "Recipient.h"



@implementation iRecoveryWatchAppDelegate

@synthesize window;
@synthesize tabBarController,tagsViewController,mapViewController,listViewController,
settingsViewController,recipientArray,currentLocation;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    	//Get the lat and lon
	
	currentLocation = [[CurrentLoc alloc] initWithLongitude:37.37688 latitude:-121.9214 delegate:self];
	
	//NSString *queryString = [NSString stringWithFormat:@"lon=%f&lat=%f&tol=3",[currentLocation latitude],[currentLocation longitude]];
	
	//[self getJSONData:queryString urlDelegate:self];
	
	NSString *queryString = [NSString stringWithFormat:@"lon=%f&lat=%f&tol=3",[currentLocation latitude],[currentLocation longitude]];
	
	[self getJSONData:queryString urlDelegate:self];
		
	
	//create tab bar controller
	tabBarController = [[UITabBarController alloc] init];

	
	//======================= TagsView ==============================================
	
	
	tagsViewController = [[TagsViewController alloc] init];
	tagsViewController.title=@"Ticker";
	tagsViewController.tabBarItem.image = [UIImage imageNamed:@"TickerTab.png"];
    
	//Create UINavigationController for tagsView
	tagsViewNavController= [[UINavigationController alloc]initWithRootViewController:tagsViewController];
	
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(location)];
	tagsViewController.navigationItem.rightBarButtonItem=barButton;
   
	
	
	//======================= MapsView ==============================================
  
	
	mapViewController = [[MapViewController alloc] init];
	mapViewController.title=@"Map";
  mapViewController.tabBarItem.image = [UIImage imageNamed:@"MapTab.png"];
  
	  //mapViewController.view.backgroundColor = [UIColor redColor];
    
	//Create UINavigationController for tagsView
	
	UINavigationController	*mapViewNavController= [[UINavigationController alloc]initWithRootViewController:mapViewController];
	
	//======================= Request ==============================================
   
	
	listViewController = [[ListViewController alloc] init];
	listViewController.title=@"Request";
	listViewController.tabBarItem.image = [UIImage imageNamed:@"RequestTab.png"];
  
	
	//listViewController.tabBarItem.image = [UIImage imageNamed:@"faves.png"];
    //listViewController.view.backgroundColor = [UIColor redColor];
    
	//Create UINavigationController for tagsView
	
	UINavigationController	*listViewNavController= [[UINavigationController alloc]initWithRootViewController:listViewController];
	
	
	// Add all the view controllers as children of the tab bar controller
   
	tabBarController.viewControllers = [NSArray arrayWithObjects:tagsViewNavController,mapViewNavController,listViewNavController, nil];

	[tagsViewNavController release];
	[mapViewNavController release];
	[listViewNavController release];
	
	
	
	
    [window addSubview:tabBarController.view];
	
    [window makeKeyAndVisible];

    return YES;
}

-(void) getJSONData:(NSString *) _queryString urlDelegate:(id)_delegate{
	
	if (_queryString == nil) {
		_queryString = [NSString stringWithFormat:@"lon=%f&lat=%f&tol=3",[currentLocation latitude],[currentLocation longitude]];
	}
	static NSString *baseURL=@"http://irecoverywatch.appspot.com/query?";
	//NSString *baseURL= [NSString stringWithString:@"http://irecoverywatch.appspot.com/query?lat=37.3&lon=-121.83&tol=5"];
	
	
	NSString *requestURL=[baseURL stringByAppendingString:_queryString];
	
	
	NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
	
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
	NSMutableData *jsonResponseData= [[NSMutableData data] retain];
	
	
	recipientArray = [[NSMutableArray alloc] init];
	
	[jsonResponseData appendData:data];	
	self.recipientArray = [self getRecipientsData:jsonResponseData];
	
	
	[tagsViewNavController.view setNeedsDisplay];
	//[mapViewController.view setNeedsDisplay];
	
	NSLog(@"Total Data Points %d",[recipientArray count]);
	
	
	
	
	//NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
	//[[NSURLConnection alloc] initWithRequest:request delegate:_delegate];
}

-(NSMutableArray *) getRecipientsData:(NSMutableData *) _responseData{
	
	NSString *responseString =[[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
	//NSLog(@"JSON Response : %@",responseString);						 
	//NSDictionary *results = [responseString JSONValue];
	NSDictionary *results = [responseString JSONValue];
	NSArray *recipients =[results objectForKey:@"results"];
	
	
	NSMutableArray *recipientReturnList = [NSMutableArray arrayWithCapacity:[recipients count]];
	for(int i=0;i<[recipients count];i++)
 {
	 NSDictionary *item= [recipients objectAtIndex:i];
		NSNumber *companyId = [item objectForKey:@"RECIP_DUNS"];
		NSString *companyName = [item objectForKey:@"RECIP_NAME"];
		NSNumber *totalAmount = [item objectForKey:@"AMT"];
		NSNumber *totalJobs = [item objectForKey:@"JOBS_COUNT"];
		NSNumber *logitude = [item objectForKey:@"LON"];
		NSNumber *latitude = [item objectForKey:@"LAT"];
		NSString *primaryAgency = [item objectForKey:@"FUNDING_AGCY"];
	    NSString *awardKey = [item objectForKey:@"AWD_KEY"];
		
		//NSLog(@"Stop here");
		
	 Recipient *recipient = [[Recipient alloc] initWithCompnayId:companyId 
													 companyName:companyName 
													 totalAmount:totalAmount 
													   totaljobs:totalJobs 
														logitude:logitude 
														latitude:latitude 
												   primaryAgency:primaryAgency
														awardKey:awardKey];
	
	
	 [recipientReturnList	addObject:recipient];
}
	
	

	return recipientReturnList;
	
}

//For Synchronous connection we may need all the delegate methods down here

#pragma mark NSURLConnection Delegate methods


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
		
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
	[connection release];
	
 }

-(void) location{
	settingsViewController= [[SettingsViewController alloc]init];
	[tagsViewNavController pushViewController:settingsViewController animated:YES];
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
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
	
	double longdiff= currentLocation.longitude - newLocation.coordinate.longitude;
	double latdiff = currentLocation.latitude - newLocation.coordinate.latitude;
	
	if ((longdiff < -3 || longdiff > 3) || ((latdiff < -3 || latdiff > 3))) {
		currentLocation.longitude=newLocation.coordinate.longitude;
		currentLocation.latitude =newLocation.coordinate.latitude;
		[tagsViewController.view setNeedsDisplay];
		NSString *queryString = [NSString stringWithFormat:@"lon=%f&lat=%f&tol=3",[currentLocation longitude],[currentLocation latitude]];
		
		[self getJSONData:queryString urlDelegate:self];
	}
	
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}


- (void)dealloc {
	
	[recipientArray release];
	[currentLocation release];
	
	[tagsViewController release];
	[mapViewController release];
	[listViewController release];
	[settingsViewController release];
	[tagsViewNavController release];
	
	
	
	[tabBarController release];
    [window release];
    [super dealloc];
}


@end
