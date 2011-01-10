//
//  UISegmentedControl+InitHelpers.m
//  Metronome
//
//  Created by paul sanwald on 1/1/11.
//  Copyright 2011 Pineapple Street Software. All rights reserved.
//

#import "UISegmentedControl+InitHelpers.h"

@implementation UISegmentedControl (UISegmentedControl_InitHelpers)

-(void) setSelectedSegmentForTitle:(NSString*)title
{
	for (int i = 0; i < [self numberOfSegments]; i++) {
		if ([title isEqualToString:[self titleForSegmentAtIndex:i]]) {
			[self setSelectedSegmentIndex:i];
		}
	}
}

@end
