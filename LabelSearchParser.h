//
//  LabelSearchParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/21/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
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
