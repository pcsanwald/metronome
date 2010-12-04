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
@synthesize isClicking, clickCount, clickSound, beatsPerMinute;

- (float) clickRateInMilliseconds {
	float interval = secondsInMinute/beatsPerMinute;
	return interval;
}
@end
