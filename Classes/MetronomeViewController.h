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


@interface MetronomeViewController : UIViewController {
	NSTimer *clickTimer;
	Click* click;
	IBOutlet UIButton *clicker;
	IBOutlet UIButton *decrementTempoButton;
	IBOutlet UIButton *incrementTempoButton;
	IBOutlet UILabel *clickStatus;
	IBOutlet UISlider *tempoSlider;
	IBOutlet UILabel *tempoLabel;

}
- (IBAction)clickerPressed:(id)sender;
- (IBAction)tempoSliderChanged:(id)sender;
- (IBAction)incrementTempo:(id)sender;
- (IBAction)decrementTempo:(id)sender;
/* TODO: make these private? 
 * no great reason to have them as public methods
 */
- (void)resetClick:(int)tempoValue;
- (void)changeTempo:(int)changeByBPMs;

@property (nonatomic, retain) NSTimer *clickTimer;
@property (nonatomic, retain) Click *click;

@end
