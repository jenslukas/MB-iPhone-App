//
//  LabelSearchParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for labels

#import <Foundation/Foundation.h>
#import "AbstractXMLParser.h"
#import "Label.h"

@interface LabelSearchParser : AbstractXMLParser {
	Label *currentLabel;
}
@property (nonatomic, retain) Label *currentLabel;
@end
