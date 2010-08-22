//
//  detailViewCompanyController.h
//  iRecoveryWatch
//
//  Created by Dantha Manikka-Baduge on 8/21/10.
//  Copyright 2010 dandil. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewCompanyController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	NSString *strKey;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *strKey;

@end
