//
//  TagView.h
//  RecoveryOne
//

#import <UIKit/UIKit.h>


@interface TagView : UIView {
  NSString *_title;
  UILabel *_titleLabel;
  UILabel *_amountLabel;
  float _amount;
  CGSize _titleSize;
  CGSize _amountSize;
  UIColor *_foregroundColor;
  UIColor *_backgroundColor;
}

- (id) initWithTitle: (NSString *)title 
              amount:(float)amount
     foregroundColor: (UIColor *)foregroundColor
     backgroundColor: (UIColor *)backgroundColor;

@end
