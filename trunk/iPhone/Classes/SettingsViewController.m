//
//  SettingsViewController.m
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright 2010 pubhttp.com. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController
@synthesize distance;

-(IBAction) distanceChanged:(id) sender{
	UISlider *slider = (UISlider *) sender;
	int progressAsInt =(int)(slider.value);
	NSString *newText =[[NSString alloc] initWithFormat:@"%d",progressAsInt];
	distance.text = newText;
	[newText release];
	
	
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	[distance release];
    [super dealloc];
}


@end
