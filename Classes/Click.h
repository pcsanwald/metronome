//
//  Click.h
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Click : NSObject <NSCoding> {
	BOOL isClicking;
	int beatsPerMinute;
	int clickCount;
	int numberOfBeatsToDisplay;
	SystemSoundID clickSound;
	NSString* clickSoundName;
	
}
- (float) clickRateInSeconds;
- (int) currentBeat;
- (void) setClickSoundUsingFilename:(NSString*) soundName;
- (void) initClickSound;

@property (nonatomic) BOOL isClicking;
@property (nonatomic) int clickCount;
@property (nonatomic) int beatsPerMinute;
@property (nonatomic) int numberOfBeatsToDisplay;
@property (nonatomic) SystemSoundID clickSound;
@property (nonatomic,copy) NSString* clickSoundName;
@end
