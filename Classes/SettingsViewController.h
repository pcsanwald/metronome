//
//  Settings.h
//  Metronome
//
//  Created by paul sanwald on 12/27/10.
//  Copyright 2010 Pineapple Street Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Click.h"
#import "UISegmentedControl+InitHelpers.h"


@interface SettingsViewController : UIViewController <UITextFieldDelegate> {
	Click* click;
	IBOutlet UILabel *beatsLabel;
	IBOutlet UISegmentedControl *beatsValue;
	IBOutlet UISegmentedControl *clickSoundValue;
	NSMutableDictionary *clickSoundNamesToFileNames;
}
@property (nonatomic, retain) Click	*click;
@property (nonatomic, retain) UISegmentedControl *clickSoundValue;


- (void)beatsValueDidChange:(id)sender;
- (void)clickSoundValueDidChange:(id)sender;

@end
