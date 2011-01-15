//
//  MetronomeViewController.m
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 Pineapple Street Software. All rights reserved.
//

#import "MetronomeViewController.h"

@implementation MetronomeViewController
@synthesize click, clickTimer;
const int minimumTempo = 20;
const int tempoRange = 200;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];	
	return self;
}

- (id)init
{
	[self initWithNibName:@"MetronomeViewController" bundle:nil];
	return self;
}

/*
 * Allow autorotation
 *
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
	if (settingsViewController) {
		[settingsViewController release];
		settingsViewController = nil;
	}
	if (![click isClicking]) {
		[clickStatus setText:[NSString stringWithFormat:@"%d",[click numberOfBeatsToDisplay]]];
	}
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

	if (![click clickSoundName]) {
		[click setClickSoundName:@"hihat"];
	}
	if (![click clickSound]) {
		[click initClickSound];
	}
	
	// set the initial value of the slider.
	float tempoSliderValue = ([click beatsPerMinute] - minimumTempo)/(float)tempoRange;
	tempoSlider.value = tempoSliderValue;

	[clickerButton setTitle:@"Start" forState:UIControlStateNormal];

	[tempoLabel setText:[NSString stringWithFormat:@"%d BPM",[click beatsPerMinute]]];
	
	[self buttonStyle:clickerButton];
	[self buttonStyle:decrementTempoButton];
	[self buttonStyle:incrementTempoButton];
	
	settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(viewSettings:)];
	[[self navigationItem] setRightBarButtonItem:settingsButton];
	[settingsButton release];
}

-(void)viewSettings:(id)sender
{
	/*
	 * initialize the settings view controller
	 */
	
	if (!settingsViewController) {
		settingsViewController = [[SettingsViewController alloc] init];
		[settingsViewController setClick:click];
	}	
	[[self navigationController] pushViewController:settingsViewController animated:YES];
	
}
- (void)buttonStyle:(UIButton*)button
{
	[[button layer] setCornerRadius:8.0f];
	[[button layer] setMasksToBounds:YES];
	[[button layer] setBorderWidth:1.0f];
	[[button layer] setBorderColor:[[UIColor blackColor] CGColor]];
	
	[button setBackgroundColor:[UIColor blackColor]];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (IBAction)clickerPressed:(id)sender
{
	if ([click isClicking]) {
		// enable the idle timer when the clicking is turned off
		[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
		[click setIsClicking:NO];
		[clickerButton setBackgroundImage:[UIImage imageNamed:@"GreenButton.png"] forState:UIControlStateNormal];
		[clickerButton setTitle:@"Start" forState:UIControlStateNormal];
		[clickTimer invalidate];
		[clickStatus setText:[NSString stringWithFormat:@"%d",[click numberOfBeatsToDisplay]]];
		[click setClickCount:0];
	} else {
		// disable the idle timer while the metronome is clicking.
		[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
		[click setIsClicking:YES];
		[clickerButton setBackgroundImage:[UIImage imageNamed:@"RedButton.png"] forState:UIControlStateNormal];
		[clickerButton setTitle:@"Stop" forState:UIControlStateNormal];
		[[NSThread currentThread] setThreadPriority:1.0];
		clickTimer = [NSTimer scheduledTimerWithTimeInterval:[click clickRateInSeconds] target:self selector:@selector(click:) userInfo:nil repeats:YES];
	}

}


- (void)click:(id)sender
{	
	CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
	[fade setFromValue:[NSNumber numberWithFloat:0.0]];
	[fade setToValue:[NSNumber numberWithFloat:1.0]];
	[fade setDelegate:self];
	
	[[clickStatus layer] addAnimation:fade forKey:@"opacity"];
	[fade setDuration:[click clickRateInSeconds]];
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
	float currentTempo = [tempoSlider value]*tempoRange + minimumTempo;
	if (currentTempo >= tempoRange+minimumTempo || currentTempo <= minimumTempo) {
		return;
	}
	float newTempoInBPM = ([tempoSlider value]*tempoRange + minimumTempo) + changeByBPMs;
	float newTempo = (newTempoInBPM - minimumTempo)/(float)tempoRange;	
	[tempoSlider setValue:newTempo];
	[self resetClick:newTempoInBPM];
}

- (IBAction)decrementTempo:(id)sender
{
	[self changeTempo:-1];
}

- (IBAction)incrementTempo:(id)sender
{
	[self changeTempo:1];
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
	[clickerButton release];
	[clickStatus release];
	[clickTimer release];
	[tempoLabel release];
	[tempoSlider release];
    [super dealloc];
}

@end
