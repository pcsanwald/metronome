//
//  Settings.m
//  Metronome
//
//  Created by paul sanwald on 12/27/10.
//  Copyright 2010 Pineapple Street Software. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController
@synthesize click,clickSoundValue;

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
	[super viewDidLoad];
	
	clickSoundNamesToFileNames = [[NSMutableDictionary alloc] initWithCapacity:3];
	[clickSoundNamesToFileNames setObject:@"hihat" forKey:@"Hi Hat"];
	[clickSoundNamesToFileNames setObject:@"stick" forKey:@"Rim Shot"];
	[clickSoundNamesToFileNames setObject:@"snare" forKey:@"Snare"];

	/* 
	 * for some reason, releasing clickSoundValue and re-initializing doesn't seem to
	 * work. so, removing all the segments and re-initializing seems the only
	 * way to go for now.
	 * TODO: figure out why releasing and re-initializing doesn't behave as I
	 * would initially expect.
	 *
	 */
	[clickSoundValue removeAllSegments];
	
	NSEnumerator *enumerator = [clickSoundNamesToFileNames keyEnumerator];
	NSString* key;
	int clickSoundValueIndex = 0;
	while ((key = (NSString*)[enumerator nextObject])) {
		[clickSoundValue insertSegmentWithTitle:key atIndex:clickSoundValueIndex animated:YES];
		NSLog(@"inserting %@ at index %d",key,clickSoundValueIndex);
		clickSoundValueIndex++;
	}
	
	NSArray *keyArray = [clickSoundNamesToFileNames allKeysForObject:[click clickSoundName]];	
	
	/*
	 * initialize the selected UISegmentedControlValue. sure seems like there should be an easier 
	 * way to do this.
	 */
	NSString *value = nil;
	NSString *fileName;
	for (NSString* key in keyArray) {
		value = (NSString*)[clickSoundNamesToFileNames objectForKey:key];
		fileName = key;
	}
	if (value != nil) {
		[clickSoundValue setSelectedSegmentForTitle:fileName];
	}
	
    [super viewDidLoad];
}

/*
 * allow autorotation for settings
 *
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
