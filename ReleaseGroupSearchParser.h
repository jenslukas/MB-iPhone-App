//
//  ReleaseGroupSearchParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for release groups

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "ReleaseGroup.h"

@interface ReleaseGroupSearchParser : AbstractXMLParser {
	NSMutableArray *releaseGroups;
	ReleaseGroup *currentReleaseGroup;
}

@property (nonatomic, retain) ReleaseGroup *currentReleaseGroup;
@end
