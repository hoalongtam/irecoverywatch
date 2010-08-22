//
//  ListViewController.h
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright 2010 pubhttp.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListViewController : UIViewController {
  IBOutlet UITextField* emailField;
  IBOutlet UITextField* amountField;
  IBOutlet UIButton * closeTextFieldButton;
}
- (IBAction)callPayPal:(id)sender;
- (IBAction)callSnailMail:(id)sender;
- (IBAction)closeTextField:(id)sender;
@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *amountField;
@property (nonatomic, retain) IBOutlet UIButton *closeTextFieldButton;
@end


@end
