//
//  detailViewCompanyController.m
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import "DetailViewCompanyController.h"

#define kAccelerometerFrequency	 .001 //Hz

@implementation DetailViewCompanyController

@synthesize webView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

	NSString *urlAddress = @"http://www.recovery.gov";
	
	//Create a URL object.
	NSURL *url = [NSURL URLWithString:urlAddress];
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {

}
/*
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	self.wvTutorial = [[WebViewController alloc] initWithNibName:@"WebView" bundle:[NSBundle mainBundle]];
	
	[window addSubview:[wvTutorial view]];
	
	// Override point for customization after app launch
	[window makeKeyAndVisible];
}
*/
- (void)dealloc {
    [super dealloc];
}


- (id)init
{
	/*
	 if (self = [super init]) {
	 }
	 */
	return self;
}
/*
- (void)loadView
{
	NSLog(@"loading view");
	
	// the base view for this view controller
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor blueColor];
	
	// important for view orientation rotation
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view = contentView;
	self.view.autoresizesSubviews = YES;
	//create a frame that will be used to size and place the web view
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
	webFrame.origin.y -= 20.0;	// shift the display up so that it covers the default open space from the content view
	UIWebView *aWebView = [[UIWebView alloc] initWithFrame:webFrame];
	self.webView = aWebView;
	//aWebView.scalesPageToFit = YES;
	aWebView.autoresizesSubviews = YES;
	aWebView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	//set the web view and acceleration delagates for the web view to be itself
	[aWebView setDelegate:self];
	//determine the path the to the index.html file in the Resources directory
	//NSString *filePathString = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
	NSString *filePathString = [NSString stringWithFormat:@"http://www.data.gov/"];
	//build the URL and the request for the index.html file
	NSURL *aURL = [NSURL fileURLWithPath:filePathString];
	NSURLRequest *aRequest = [NSURLRequest requestWithURL:aURL];
	//load the index.html file into the web view.
	[aWebView loadRequest:aRequest];
	
	//add the web view to the content view
	[contentView addSubview:webView];
	
	[aWebView release];
	[contentView release];
 
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations.
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	/*
	if(fromInterfaceOrientation == UIInterfaceOrientationPortrait){
		NSString* result = [webView stringByEvaluatingJavaScriptFromString:@"rotate(0)"];
		//NSString a = *result;
		NSLog(result);
		
	}
	else{
		[webView stringByEvaluatingJavaScriptFromString:@"rotate(1)"];
	}
	*/
	
	//[self.webView sizeToFit];
	//CGRect curBounds = [[UIScreen mainScreen] bounds];
	//[self.webView setBounds:self.origViewRectangle];
	//[[UIScreen mainScreen] bounds]]
	//NSLog(@"orienting");
}

- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
	
	//NSString* javaScriptCall = [NSString stringWithFormat:@"accelerate(%f, %f, %f)", acceleration.x, acceleration.y, acceleration.z];
	
	//[webView stringByEvaluatingJavaScriptFromString:javaScriptCall];
	
	//Use a basic low-pass filter to only keep the gravity in the accelerometer values
	//_accelerometer[0] = acceleration.x * kFilteringFactor + _accelerometer[0] * (1.0 - kFilteringFactor);
	//_accelerometer[1] = acceleration.y * kFilteringFactor + _accelerometer[1] * (1.0 - kFilteringFactor);
	//_accelerometer[2] = acceleration.z * kFilteringFactor + _accelerometer[2] * (1.0 - kFilteringFactor);
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	NSLog(@"An error happened during load");
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
	NSLog(@"loading started");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"finished loading");
}

@end

