//
//  LabelLookUpParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/16/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for labels

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "Label.h"
#import "Release.h"

@interface LabelLookUpParser : AbstractXMLParser {
	Label *currentLabel;
	Release *currentRelease;
	bool parsingTags;
}

@property (nonatomic, retain) Label *currentLabel;
@property (nonatomic, retain) Release *currentRelease;
@end
