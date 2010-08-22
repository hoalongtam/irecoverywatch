//
//  TagsViewController.m
//  iRecoveryWatch
//

#import "TagsViewController.h"
#import "TagStripView.h"
#import "TagView.h"
#import "Recipient.h"
#import "iRecoveryWatchAppDelegate.h"

#define STRIP_COUNT 3

@interface TagsViewController (PrivateMethods)

- (void) calculateLayout;
- (void) loadData: (NSArray *)items;

@end

@implementation TagsViewController


/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	self.navigationController.toolbar.barStyle = UIBarStyleBlack;
	
	self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, 360);
	
	UIImageView *backgroundView = [[UIImageView alloc] 
								   initWithImage: [UIImage imageNamed: @"TagBackground"]];
	[self.view addSubview: backgroundView];
	
	stripViews = [[NSMutableArray alloc] initWithCapacity: STRIP_COUNT];
	CGFloat w = self.view.frame.size.width;
	CGFloat h = self.view.frame.size.height / 3;
	CGFloat y = 0;
	for(int i = 0 ; i < STRIP_COUNT ; ++i) {
		TagStripView *strip = [[TagStripView alloc] initWithFrame:CGRectMake(0, y, w, h)];
		strip.speed = 2 + (2 + i) % STRIP_COUNT;
    strip.reverse = (i % 2);
		[stripViews addObject:strip];
		[self.view addSubview:strip];
		y += h;
	}
  iRecoveryWatchAppDelegate *delegate = (iRecoveryWatchAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self loadData:delegate.recipientArray];
	for(int i = 0 ; i < STRIP_COUNT ; ++i) {
		TagStripView *strip = [stripViews objectAtIndex: i];
		[strip calculateLayout];    
	}
	
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark PrivateMethods

- (void) loadData:(NSArray *)items {
  int i = 0;
  
  for (Recipient *recipient in items) {
		float grayness = 0.6 + (rand() % 40) / 100.0;
		UIColor *backgroundColor = [UIColor colorWithRed: grayness
                                               green: grayness
                                                blue: grayness 
                                               alpha: 0.2 + (rand() % 60) / 100.0];
		TagView *tagView = [[TagView alloc] initWithTitle: recipient.companyName
                                               amount: [recipient.totalAmount floatValue]
                                      foregroundColor: [UIColor whiteColor]
                                      backgroundColor: backgroundColor];
		[tagView sizeToFit];
		
		TagStripView *strip = [stripViews objectAtIndex: i % STRIP_COUNT];
		[strip addTagView: tagView];
    i++;
	}
	for(int i = 0 ; i < STRIP_COUNT ; ++i) {
		TagStripView *strip = [stripViews objectAtIndex: i];
		[strip calculateLayout];    
	}
}

@end
