//
//  ReleaseParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/5/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: Concrete implementation of the XML parser for releases

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "Release.h"

@interface ReleaseParser : AbstractXMLParser {
	Release *currentRelease;
}
@property (nonatomic, retain) Release *currentRelease;
@end
