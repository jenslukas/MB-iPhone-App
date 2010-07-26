//
//  Release.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/7/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Release entity

#import "Release.h"

@implementation Release
@synthesize mbid, title, score, artist, date, tracks;

-(void) dealloc {
	[mbid release];
	[title release];
	[artist release];
	[date release];
	tracks = nil;
	[tracks release];
	[super dealloc];
}
@end
