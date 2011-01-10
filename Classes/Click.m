//
//  Click.m
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 Pineapple Street Software. All rights reserved.
//

#import "Click.h"

const float secondsInMinute = 60.0;

@implementation Click
@synthesize isClicking, clickCount, clickSound, beatsPerMinute, numberOfBeatsToDisplay, clickSoundName;

- (float) clickRateInSeconds {
	float interval = secondsInMinute/beatsPerMinute;
	return interval;
}

- (int) currentBeat {
	return clickCount % numberOfBeatsToDisplay + 1;
}

- (id)init 
{
	if (clickSoundName) {
		[self setClickSoundUsingFilename:clickSoundName];
	}
	[super init];
	return self;
}
- (void) setClickSoundUsingFilename:(NSString*) soundName 
{
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
	if (soundPath) {
		NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
		// register sound file
		SystemSoundID newClickSound;
		OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &newClickSound);
		clickSound = newClickSound;
		if (err != kAudioServicesNoError) {
			NSLog(@"Couldn't load %@, error code %d",soundURL,err);
		}
	} else {
		NSLog(@"Could not load short sound!");
	}
	[self setClickSoundName:soundName];
}

- (void)initClickSound
{
	[self setClickSoundUsingFilename:clickSoundName];
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
	// for each instance variable, archive it under its variable name
	[encoder encodeInt:beatsPerMinute forKey:@"beatsPerMinute"];	
	[encoder encodeInt:numberOfBeatsToDisplay forKey:@"numberOfBeatsToDisplay"];
	[encoder encodeObject:clickSoundName forKey:@"clickSoundName"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	[super init];
	// For each archived instance variable, decode it, and pass to setters, where it is retained.
	[self setBeatsPerMinute:[decoder decodeIntForKey:@"beatsPerMinute"]];
	[self setNumberOfBeatsToDisplay:[decoder decodeIntForKey:@"numberOfBeatsToDisplay"]];
	[self setClickSoundName:[decoder decodeObjectForKey:@"clickSoundName"]];

	return self;
}

@end
