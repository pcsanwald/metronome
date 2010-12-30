//
//  Settings.m
//  Metronome
//
//  Created by paul sanwald on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController
@synthesize click;

- (void)viewWillAppear:(BOOL)animated
{
	[beatsValue setSelectedSegmentIndex:[click numberOfBeatsToDisplay]-1];
	[beatsValue addTarget:self action:@selector(beatsValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)beatsValueDidChange:(id)sender
{
	int n = [[beatsValue titleForSegmentAtIndex:[beatsValue selectedSegmentIndex]] integerValue];
	[click setNumberOfBeatsToDisplay:n];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
 * Allow autorotation
 *
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[click release];
	[beatsLabel release];
	[beatsValue release];
    [super dealloc];
}


@end
