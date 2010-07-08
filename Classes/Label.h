//
//  Label.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/22/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Label Entity

#import <Foundation/Foundation.h>


@interface Label : NSObject {
	NSString *mbid;
	NSString *name;
	NSInteger score;
}
@property (nonatomic, retain) NSString *mbid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSInteger score;
@end
