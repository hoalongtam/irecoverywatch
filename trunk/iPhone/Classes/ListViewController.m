	//
	//  ListViewController.m
	//  iRecoveryWatch
	//
	//  Created by Muthu on 8/21/10.
	//  Copyright 2010 pubhttp.com. All rights reserved.
	//

	#import "ListViewController.h"


	@implementation ListViewController
	@synthesize emailField, amountField, closeTextFieldButton;

	- (void)viewDidLoad {
		[super viewDidLoad];
		emailField.text = @"buyer1_1282422017_per@yahoo.com";
		[amountField becomeFirstResponder];
	}

	- (void)didReceiveMemoryWarning {
		[super didReceiveMemoryWarning];
		
		NSLog(@"Did didReceiveMemoryWarning - ListViewController.m");
	}


	- (IBAction)callSnailMail:(id)sender {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you nuts?" message:@"Use PayPay, it's faster." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	- (IBAction)callPayPal:(id)sender {
		
		//NSString *email = [emailField text];
		//float amount = (float)[[amountField text] floatValue];
		
		//NSString *url=[NSString stringWithFormat:@"https://pp-recv-money.appspot.com/receivemoney?senderEmail=%@&receiverEmail=%@&amount=%.2f&memo=stimulus", email, @"seller_1282422068_biz@yahoo.com", amount];
		//NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
		//NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
		//NSLog(@"Email response %@",data);
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Application Submitted" message:@"Check your email for updates from the Federal Government" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		//data = nil;
		[alert show];
		[alert release];
	}
	- (IBAction)closeTextField:(id)sender {
		[emailField resignFirstResponder];
		[amountField resignFirstResponder];
	}

	- (void)dealloc {
		[emailField release];
		[amountField release];
		[closeTextFieldButton release];
		[super dealloc];
	}



	@end
