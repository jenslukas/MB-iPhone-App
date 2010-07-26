//
//  ReleaseGroup.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/25/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: ReleaseGroup entity

#import <Foundation/Foundation.h>


@interface ReleaseGroup : NSObject {
	NSString *title;
	NSString *mbid;
	NSString *type;
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *mbid;
@property (nonatomic, retain) NSString *type;
@end
