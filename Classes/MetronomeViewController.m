//
//  MetronomeViewController.m
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MetronomeViewController.h"

@implementation MetronomeViewController
@synthesize click, clickTimer;
const int minimumTempo = 20;
const int tempoRange = 200;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
	}
    return self;
}

- (id)init
{
	[self initWithNibName:@"MetronomeViewController" bundle:nil];
	return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if (!click) {
		click = [[Click alloc] init];
		[click setNumberOfBeatsToDisplay:4];
		[click setBeatsPerMinute:120];
	}
	
	if ([click numberOfBeatsToDisplay] == 0) {
		[click setNumberOfBeatsToDisplay:4];
	}
	if ([click beatsPerMinute] == 0) {
		[click setBeatsPerMinute:60];
	}
	[click setIsClicking:NO];
	[click setClickCount:0];


	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"hihat" ofType:@"wav"];
	if (soundPath) {
		NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
		// register sound file
		SystemSoundID clickSound;
		OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &clickSound);
		[click setClickSound:clickSound];
		if (err != kAudioServicesNoError) {
			NSLog(@"Couldn't load %@, error code %d",soundURL,err);
		}
	} else {
		NSLog(@"Could not load short sound!");
	}

	// set the initial value of the slider.
	float tempoSliderValue = ([click beatsPerMinute] - minimumTempo)/(float)tempoRange;
	tempoSlider.value = tempoSliderValue;

	[clicker setTitle:@"Start" forState:UIControlStateNormal];
	[clickStatus setText:[NSString stringWithFormat:@"%d beats",[click numberOfBeatsToDisplay]]];
	[tempoLabel setText:[NSString stringWithFormat:@"%d BPM",[click beatsPerMinute]]];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)clickerPressed:(id)sender
{
	if ([click isClicking]) {
		[click setIsClicking:NO];
		[clicker setTitle:@"Start" forState:UIControlStateNormal];
		[clickTimer invalidate];
		[clickStatus setText:[NSString stringWithFormat:@"%d beats",[click numberOfBeatsToDisplay]]];
		[click setClickCount:0];
	} else {
		[click setIsClicking:YES];
		[clicker setTitle:@"Stop" forState:UIControlStateNormal];
		clickTimer = [NSTimer scheduledTimerWithTimeInterval:[click clickRateInSeconds] target:self selector:@selector(click:) userInfo:nil repeats:YES];
	}
}

- (void)click:(id)sender
{
	CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
	[fade setDuration:[click clickRateInSeconds]];
	[fade setFromValue:[NSNumber numberWithFloat:0.0]];
	[fade setToValue:[NSNumber numberWithFloat:1.0]];
	[fade setDelegate:self];
	[[clickStatus layer] addAnimation:fade forKey:@"opacity"];
	
	[clickStatus setText:[NSString stringWithFormat:@"%d",[click currentBeat]]];
	AudioServicesPlaySystemSound([click clickSound]);
		
	[click setClickCount:[click clickCount]+1];
}

- (IBAction)tempoSliderChanged:(id)sender
{
	// TODO: sort of a trivial calculation, but worth extrapolating into its own method maybe?
	// might make refactoring a bit easier
	
	// The UISlider gives us float values of 0.0 - 1.0, convert them into the range we want.
	int tempoValue = [tempoSlider value]*tempoRange + minimumTempo;

	[self resetClick:tempoValue];	
}

- (void)resetClick:(int)tempoValue
{
	[tempoLabel setText:[NSString stringWithFormat:@"%d BPM",tempoValue]];
	[click setBeatsPerMinute:tempoValue];

	if ([click isClicking]) {
		[clickTimer invalidate];
		clickTimer = [NSTimer scheduledTimerWithTimeInterval:[click clickRateInSeconds] target:self selector:@selector(click:) userInfo:nil repeats:YES];
	}	
}

- (void)changeTempo:(int)changeByBPMs
{
	float newTempoInBPM = ([tempoSlider value]*tempoRange + minimumTempo) + changeByBPMs;
	float newTempo = (newTempoInBPM - minimumTempo)/(float)tempoRange;	
	[tempoSlider setValue:newTempo];
	[self resetClick:newTempoInBPM];
}

- (IBAction)decrementTempo:(id)sender
{
	[self changeTempo:-1];
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
	[clicker release];
	[clickStatus release];
	[clickTimer release];
	[tempoLabel release];
	[tempoSlider release];
    [super dealloc];
}

@end
