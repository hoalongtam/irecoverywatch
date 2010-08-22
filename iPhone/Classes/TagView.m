//
//  TagView.m
//  RecoveryOne
//
//  Created by Mike Sax on 8/21/10.
//  Copyright 2010 Sax Software Corp. All rights reserved.
//

#import "TagView.h"
#import "DetailViewCompanyController.h"

#define X_MARGIN 20
#define Y_MARGIN 10
#define Y_GAP 5

@interface TagView (PrivateMethods)
- (NSString *)smartWrap: (NSString *)text;
@end

@implementation TagView

#pragma mark NSObject

- (id) initWithTitle: (NSString *)title 
              amount:(float)amount
     foregroundColor: (UIColor *)foregroundColor
     backgroundColor: (UIColor *)backgroundColor
      viewController: (TagsViewController *)aViewController {
  if(self = [super init]) {
    _foregroundColor = foregroundColor;
    _backgroundColor = backgroundColor;
    viewController = aViewController;
    _title = [self smartWrap: title];
    _titleLabel = [[UILabel alloc] initWithFrame: CGRectNull];
    _titleLabel.lineBreakMode =  UILineBreakModeWordWrap;
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = _title;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = _foregroundColor;
    
    CGFloat titleSize = 12;
    if (amount > 1000000)
      titleSize = 16.0;
    else if (amount > 100000)
      titleSize = 14;
    else if (amount > 10000)
      titleSize = 12;

//    NSLog(@"Amount: %f Fontsize: %f", amount, titleSize);
    _titleLabel.font = [UIFont fontWithName:@"Arial" size: titleSize];
    
    _amountLabel = [[UILabel alloc] initWithFrame: CGRectNull];
    if (amount > 0.0) {
      NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
      [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
      _amountLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:amount]];     
    }
    else {
      _amountLabel.text = @"";
    }

 
    _amountLabel.backgroundColor = [UIColor clearColor];
    _amountLabel.font = [UIFont fontWithName:@"Arial" size: 12.0];
    _amountLabel.textColor = _foregroundColor;
    [self addSubview: _titleLabel];
    [self addSubview: _amountLabel];
  }
  self.frame = CGRectMake(0, 0, 320.0, 320.0);
  self.backgroundColor = [UIColor clearColor];
  return self;
}

- (void)dealloc {
  [_title release];
  [_titleLabel release];
  [_amountLabel release];
  [_foregroundColor release];
  [_backgroundColor release];
  [super dealloc];
}

#pragma mark UIView

- (CGSize)sizeThatFits:(CGSize)size {
  _titleSize = [_titleLabel sizeThatFits: size];
  _amountSize = [_amountLabel sizeThatFits: size]; 
  CGFloat maxWidth = _titleSize.width > _amountSize.width ? _titleSize.width : _amountSize.width;
  return CGSizeMake(maxWidth + X_MARGIN * 2, 
                    _titleSize.height + _amountSize.height + Y_GAP + Y_MARGIN * 2);
}

- (void)layoutSubviews {
  _titleLabel.frame = CGRectMake(X_MARGIN, Y_MARGIN, _titleSize.width, _titleSize.height);
  _amountLabel.frame = CGRectMake(self.frame.size.width - _amountSize.width - X_MARGIN, 
                                  CGRectGetMaxY(_titleLabel.frame) + Y_GAP, 
                                  _amountSize.width, _amountSize.height);
  [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  //CGContextSetShadow(context, CGSizeMake(4,-5), 10);
  
//  CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
  CGContextSetLineWidth(context, 0);
  const float* colors = CGColorGetComponents(_backgroundColor.CGColor);
  CGContextSetRGBFillColor(context, 
                           colors[0], colors[1], colors[2], colors[3]);

  CGRect rrect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
  CGFloat radius = 10;
  CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
  CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
  
  CGContextMoveToPoint(context, minx, midy);
  CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
  CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
  CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
  CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
  CGContextClosePath(context);
  CGContextDrawPath(context, kCGPathFillStroke);

  CGContextRestoreGState(context);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  NSLog(@"TOUCHED! %@", _titleLabel.text);
  DetailViewCompanyController *detailView = [[DetailViewCompanyController alloc] init];
	
	[[viewController navigationController] pushViewController:detailView animated:YES];
	
	[detailView release];
  
}
#pragma mark Private Methods

// Perform word wrap that creates a nice tag shape
- (NSString *)smartWrap: (NSString *)text {
  NSArray *words = [text componentsSeparatedByString:@" "];
  NSMutableArray *lines = [[[NSMutableArray alloc] init] autorelease];
  NSMutableString *currentLine = [[[NSMutableString alloc] init] autorelease];
  NSString *word;
  // What's the longest word
  int longestWordLength = 0;
  for (word in words) {
    if (longestWordLength < [word length])
      longestWordLength = [word length];
  }
  // Fill up the lines 
  
  // If too many lines, make it wider
  if ([words count] > 6) 
    longestWordLength *= 2;
  for (word in words) {
    // We allow a bit more than the longest word
    if ([currentLine length] + [word length] + 1 <= longestWordLength + 4) 
      [currentLine appendFormat: [currentLine length] ? @" %@" : @"%@ ", word];
    else {
      [lines addObject: [currentLine copy]];
      [currentLine setString: word];
    }
  }
  if ([currentLine length])
    [lines addObject: currentLine];
  return [lines componentsJoinedByString: @"\n"];
}

@end
