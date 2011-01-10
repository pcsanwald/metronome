//
//  MetronomeAppDelegate.h
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 Pineapple Street Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetronomeViewController.h"

@interface MetronomeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MetronomeViewController *mvc;
	UINavigationController *navController;
}
-(NSString*) clickPath;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

