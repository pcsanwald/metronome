//
//  Click.m
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Click.h"

const float secondsInMinute = 60.0;

@implementation Click
@synthesize isClicking, clickCount, clickSound, beatsPerMinute, numberOfBeatsToDisplay;

- (float) clickRateInSeconds {
	float interval = secondsInMinute/beatsPerMinute;
	return interval;
}

- (int) currentBeat {
	return clickCount % numberOfBeatsToDisplay + 1;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	// for each instance variable, archive it under its variable name
	[encoder encodeInt:beatsPerMinute forKey:@"beatsPerMinute"];	
}

- (id)initWithCoder:(NSCoder *)decoder
{
	[super init];
	// For each archived instance variable, decode it, and pass to setters, where it is retained.
	[self setBeatsPerMinute:[decoder decodeIntForKey:@"beatsPerMinute"]];
	return self;
}

@end
