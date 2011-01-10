//
//  MetronomeAppDelegate.m
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 Pineapple Street Software. All rights reserved.
//

#import "MetronomeAppDelegate.h"
#import "MetronomeViewController.h"

@implementation MetronomeAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	mvc = [[MetronomeViewController alloc] init];
	
	// un-archive the click if it exists
	NSString *clickPath = [self clickPath];
	// unarchive it into an array
	Click *click = [NSKeyedUnarchiver unarchiveObjectWithFile:clickPath];
	
	if (!click) {
		click = [[[Click alloc] init] autorelease];
	} 	
	[mvc setClick:click];
	
	navController = [[UINavigationController alloc] initWithRootViewController:mvc];
	[[navController navigationBar] setBarStyle:UIBarStyleBlack];
	[window addSubview:[navController view]];
	
    [self.window makeKeyAndVisible];	
    return YES;
}

-(NSString*) clickPath
{
	return pathInDocumentDirectory(@"Click.data");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	//Archive possessions to a file
	[NSKeyedArchiver archiveRootObject:[mvc click] toFile:[self clickPath]];
	
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	[self applicationDidEnterBackground:application];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navController release];
	[mvc release];
    [window release];
    [super dealloc];
}


@end
