//
//  TagStripView.m
//  iRecoveryWatch
//
//  Created by Mike Sax on 8/21/10.
//  Copyright 2010 Sax Software Corp. All rights reserved.
//

#import "TagStripView.h"
#import "TagView.h"

#define X_GAP 30
#define Y_GAP 10
#define X_MARGIN 10
#define Y_MARGIN 5

@interface TagStripView (PrivateMethods)
- (void) scrollTick;
@end

@implementation TagStripView

@synthesize speed=_speed, reverse=_reverse;

#pragma mark NSObject

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
      tagViews = [[NSMutableArray alloc] init];
      scrollTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03
                                                     target: self
                                                   selector: @selector(scrollTick)
                                                   userInfo: nil
                                                    repeats: YES];
      speed = 1;
    }
    return self;
}

- (void)dealloc {
  [tagViews release];
  [super dealloc];
}

#pragma mark Public Methods

- (void)addTagView: (TagView *)tagView {
  [self addSubview: tagView];
  [tagViews addObject: tagView];
}

- (void)calculateLayout {
  CGFloat x = self.frame.size.width;
  CGFloat y = 0;
  CGFloat frameHeight = self.frame.size.height;
  
  for(TagView *tagView in tagViews) {
    CGFloat width = tagView.frame.size.width;
    CGFloat height = tagView.frame.size.height;
    x += X_GAP;
    y = (frameHeight - height - (((rand() % 100) - 50) / 100.0) * 3 * Y_MARGIN) / 2.0;
    tagView.frame = CGRectMake(x, y, width, height);
    x += width;
  }
  self.contentSize = CGSizeMake(x + self.frame.size.width, frameHeight); 
  self.showsHorizontalScrollIndicator= NO;
}

#pragma mark  PrivateMethods
- (void) scrollTick {
  if (_reverse) {
    if (self.contentOffset.x <= 4) {
      self.contentOffset = CGPointMake(self.contentSize.width - self.frame.size.width, 0);      
    }
    self.contentOffset = CGPointMake(self.contentOffset.x - (_speed / 2.0), self.contentOffset.y);
  } else {
    self.contentOffset = CGPointMake(self.contentOffset.x + (_speed / 2.0), self.contentOffset.y);
    if (self.contentOffset.x + self.frame.size.width > self.contentSize.width)
      self.contentOffset = CGPointMake(0, 0);    
  }
}
@end
