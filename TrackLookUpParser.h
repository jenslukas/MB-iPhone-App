//
//  TrackLookUpParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/26/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for track

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "Track.h"

@interface TrackLookUpParser : AbstractXMLParser {
	Track *track;
}

@property (nonatomic, retain) Track *track;
@end
