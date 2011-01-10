/*
 *  FileHelper.m
 *  Metronome
 *
 *  Created by paul sanwald on 12/5/10.
 *  Copyright 2010 Pineapple Street Software. All rights reserved.
 *
 */

#include "FileHelper.h"

NSString *pathInDocumentDirectory(NSString *fileName)
{
	// get list of document directories in sandbox
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	// get one and only one document directory for that list
	NSString *documentDirectory = [documentDirectories objectAtIndex:0];
	
	// append passed in filename to that directory and return it
	return [documentDirectory stringByAppendingPathComponent:fileName];
	
}