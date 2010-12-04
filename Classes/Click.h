//
//  Click.h
//  Metronome
//
//  Created by paul sanwald on 12/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Click : NSObject {
	BOOL isClicking;
	int beatsPerMinute;
	int clickCount;
	SystemSoundID clickSound;
	
}
- (float) clickRateInMilliseconds;
@property (nonatomic) BOOL isClicking;
@property (nonatomic) int clickCount;
@property (nonatomic) int beatsPerMinute;
@property (nonatomic) SystemSoundID clickSound;
@end
