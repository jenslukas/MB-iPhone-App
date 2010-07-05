//
//  ReleaseLookUpParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/12/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: Concrete implementation of the XML parser for releases

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "Release.h"
#import "Track.h"

@interface ReleaseLookUpParser : AbstractXMLParser {
	Release *currentRelease;
	Track *currentTrack;
	bool parsingTrack;
}
@property (nonatomic, retain) Release *currentRelease;
@property (nonatomic, retain) Track *currentTrack;
@end
