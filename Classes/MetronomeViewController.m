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
        // Custom initialization.
		NSLog(@"Custom initialization!");
		tempoSlider.value = 0.5f;
		}
    return self;
}

- (id)init
{
	[self initWithNibName:@"MetronomeViewController" bundle:nil];
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	click = [[Click alloc] init];
	
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
	
	[clicker setTitle:@"Start" forState:UIControlStateNormal];
	[clickStatus setText:@"1"];
	[click setIsClicking:NO];
	[click setBeatsPerMinute:120];
	[tempoLabel setText:[NSString stringWithFormat:@"%d BPM",[click beatsPerMinute]]];
	[click setClickCount:0];
	
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
	NSLog(@"Clicker pressed!");
	if ([click isClicking]) {
		[click setIsClicking:NO];
		[clicker setTitle:@"Start" forState:UIControlStateNormal];
		[clickTimer invalidate];
	} else {
		[click setIsClicking:YES];
		[clicker setTitle:@"Stop" forState:UIControlStateNormal];
		clickTimer = [NSTimer scheduledTimerWithTimeInterval:[click clickRateInMilliseconds] target:self selector:@selector(click:) userInfo:nil repeats:YES];
	}
}

- (void)click:(id)sender
{
	AudioServicesPlaySystemSound([click clickSound]);
	[click setClickCount:[click clickCount]+1];
	[clickStatus setText:[NSString stringWithFormat:@"%d",[click clickCount]]];
	[clickTimer invalidate];
	clickTimer = [NSTimer scheduledTimerWithTimeInterval:[click clickRateInMilliseconds] target:self selector:@selector(click:) userInfo:nil repeats:YES];
}

- (IBAction)tempoChanged:(id)sender
{
	// TODO: sort of a trivial calculation, but worth extrapolating into its own method maybe?
	// might make refactoring a bit easier
	
	// The UISlider gives us float values of 0.0 - 1.0 convert them into the range we want.
	int tempoValue = [tempoSlider value]*tempoRange + minimumTempo;
	[tempoLabel setText:[NSString stringWithFormat:@"%d BPM",tempoValue]];
	[click setBeatsPerMinute:tempoValue];
	
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
