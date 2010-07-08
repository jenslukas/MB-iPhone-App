//
//  ReleaseSearchParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for releases

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "Release.h"

@interface ReleaseSearchParser : AbstractXMLParser {
	Release *currentRelease;
}
@property (nonatomic, retain) Release *currentRelease;
@end
