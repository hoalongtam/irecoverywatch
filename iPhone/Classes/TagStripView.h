//
//  TagStripView.h
//  iRecoveryWatch
//
//  Created by Mike Sax on 8/21/10.
//  Copyright 2010 Sax Software Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagView;

@interface TagStripView : UIScrollView {
  NSMutableArray *tagViews;
  NSTimer *scrollTimer;
  int speed;
  BOOL _reverse;
}

- (void)addTagView: (TagView *)tagView;
- (void)calculateLayout;

@property int speed;
@property BOOL reverse;

@end
