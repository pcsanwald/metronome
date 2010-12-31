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
	[clickSoundValue addTarget:self action:@selector(clickSoundValueDidChange:) forControlEvents:UIControlEventValueChanged];
		
}

- (void)beatsValueDidChange:(id)sender
{
	// this will backfire if I ever change the title to "one" or "two" instead of integers
	int n = [[beatsValue titleForSegmentAtIndex:[beatsValue selectedSegmentIndex]] integerValue];
	[click setNumberOfBeatsToDisplay:n];
}

- (void)clickSoundValueDidChange:(id)sender
{
	NSString *title = [clickSoundNamesToFileNames objectForKey:
					   [clickSoundValue titleForSegmentAtIndex:
						[clickSoundValue selectedSegmentIndex]]];
	[click setClickSoundUsingFilename:title];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	clickSoundNamesToFileNames = [[NSMutableDictionary alloc] initWithCapacity:2];
	[clickSoundNamesToFileNames setObject:@"hihat" forKey:@"hi hat"];
	[clickSoundNamesToFileNames setObject:@"stick" forKey:@"rim shot"];
	
	NSArray *keyArray = [clickSoundNamesToFileNames allKeysForObject:[click clickSoundName]];
	
	/*
	 * initialize the UISegmentedControlValue. sure seems like there should be an easier 
	 * way to do this.
	 */
	NSString *value;
	NSString *fileName;
	for (NSString* key in keyArray) {
		value = (NSString*)[clickSoundNamesToFileNames objectForKey:key];
		fileName = key;
	}
	if (value) {
		for (int i = 0; i < [clickSoundValue numberOfSegments]; i++) {
			if ([fileName isEqualToString:[clickSoundValue titleForSegmentAtIndex:i]]) {
				[clickSoundValue setSelectedSegmentIndex:i];
			}
		}
	}
	
    [super viewDidLoad];
}

/*
 * Don't allow autorotation for settings
 *
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	//return YES;
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
	[clickSoundValue release];
	[clickSoundNamesToFileNames release];
    [super dealloc];
}


@end
