//
//  ArtistSearchParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for artists

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "Artist.h"

@interface ArtistSearchParser : AbstractXMLParser {
	Artist *currentArtist;
	bool parsingArtist;
}
@property (nonatomic, retain) Artist *currentArtist;
@end
