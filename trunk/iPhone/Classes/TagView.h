//
//  TagView.h
//  RecoveryOne
//

#import <UIKit/UIKit.h>

@class TagsViewController;

@interface TagView : UIView {
  NSString *_title;
  UILabel *_titleLabel;
  UILabel *_amountLabel;
  float _amount;
  CGSize _titleSize;
  CGSize _amountSize;
  UIColor *_foregroundColor;
  UIColor *_backgroundColor;
  TagsViewController *viewController;
}

- (id) initWithTitle: (NSString *)title 
              amount:(float)amount
     foregroundColor: (UIColor *)foregroundColor
     backgroundColor: (UIColor *)backgroundColor
      viewController: (TagsViewController *)aViewController;

@end
