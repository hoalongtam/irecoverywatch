//
//  RequestFundingViewController.h
//  RequestFunding
//
//  Created by John Varghese on 8/22/10.
//  Copyright (c) 2010 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestFundingViewController : UIViewController {

    IBOutlet UIPickerView *DollarAmounts;
}

- (IBAction)callPayPal:(id)sender;
@property (nonatomic, retain) IBOutlet UIPickerView *DollarAmounts;
@end

