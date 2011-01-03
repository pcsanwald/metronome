//
//  MetronomeViewController.h
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import "Click.h"
#import "SettingsViewController.h"


@interface MetronomeViewController : UIViewController {
	NSTimer *clickTimer;
	Click* click;
	IBOutlet UIButton *clickerButton;
	IBOutlet UIButton *decrementTempoButton;
	IBOutlet UIButton *incrementTempoButton;
	IBOutlet UILabel *clickStatus;
	IBOutlet UISlider *tempoSlider;
	IBOutlet UILabel *tempoLabel;
	
	UIBarButtonItem *settingsButton;
	
	SettingsViewController *settingsViewController;	
}
- (IBAction)clickerPressed:(id)sender;
- (IBAction)tempoSliderChanged:(id)sender;
- (IBAction)incrementTempo:(id)sender;
- (IBAction)decrementTempo:(id)sender;
- (void)viewSettings:(id)sender;


/* TODO: make these private? 
 * no great reason to have them as public methods
 */
- (void)resetClick:(int)tempoValue;
- (void)changeTempo:(int)changeByBPMs;
- (void)buttonStyle:(UIButton*)button;

@property (nonatomic, retain) NSTimer *clickTimer;
@property (nonatomic, retain) Click *click;

@end
