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
	IBOutlet UILabel *clickStatus;
	IBOutlet UISlider *tempoSlider;
	IBOutlet UILabel *tempoLabel;

}
- (IBAction)clickerPressed:(id)sender;
- (IBAction)tempoChanged:(id)sender;

@property (nonatomic, retain) NSTimer *clickTimer;
@property (nonatomic, retain) Click *click;

@end
