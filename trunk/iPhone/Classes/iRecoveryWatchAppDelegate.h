//
//  iRecoveryWatchAppDelegate.h
//  iRecoveryWatch
//
//  Created by Muthu on 8/21/10.
//  Copyright pubhttp.com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  TickerViewController;
@class  TagsViewController;
@class 	MapViewController;
@class  ListViewController;



@interface iRecoveryWatchAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
    TickerViewController *tickerViewController;
	TagsViewController *tagsViewController;
	MapViewController *mapViewController;
	ListViewController *listViewController;
	
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) TickerViewController *tickerViewController;
@property (nonatomic, retain) TagsViewController *tagsViewController;
@property (nonatomic, retain) MapViewController *mapViewController;
@property (nonatomic, retain) ListViewController *listViewController;


@end

