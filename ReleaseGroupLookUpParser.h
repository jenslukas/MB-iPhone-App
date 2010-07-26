//
//  ReleaseGroupLookUpParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/26/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for release groups

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import	"ReleaseGroup.h"
#import "Release.h"

@interface ReleaseGroupLookUpParser : AbstractXMLParser {
	ReleaseGroup *releaseGroup;
	Release *currentRelease;
	bool parsingTags;
	bool parsingRelease;
}
@property (nonatomic, retain) ReleaseGroup *releaseGroup;
@property (nonatomic, retain) Release *currentRelease;
@end
