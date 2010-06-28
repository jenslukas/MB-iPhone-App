//
//  ArtistSearchParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/21/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: Concrete implementation of the XML parser for artists

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "Artist.h"

@interface ArtistSearchParser : AbstractXMLParser {
	Artist *currentArtist;
}
@property (nonatomic, retain) Artist *currentArtist;
@end
