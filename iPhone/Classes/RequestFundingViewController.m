//
//  RequestFundingViewController.m
//  RequestFunding
//
//  Created by John Varghese on 8/22/10.
//  Copyright (c) 2010 Home. All rights reserved.
//

#import "RequestFundingViewController.h"

@implementation RequestFundingViewController
@synthesize DollarAmounts;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dollars = [[[NSArray alloc] initWithObjects:@"$100,000", @"$500,000", @"$ 1 Million", @"$ 2 Million", @"$ 3 Million", @"$ 4 Million", 
                        @"$ 5 Million", @"$ 6 Million", @"$ 7 Million", @"$ 8 Million", nil] autorelease];
    
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void) callPayPal:(id)sender {
    NSLog(@"Load the paypal controller");
}
- (void)dealloc {
    [super dealloc];
}

@end
