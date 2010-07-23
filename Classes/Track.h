//
//  Track.h
//  Musicbrainz
//
//  Created by Peter Katheter on 6/28/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Track Entity
#import <Foundation/Foundation.h>


@interface Track : NSObject {
	NSString *mbid;
	NSInteger position;
	NSString *title;
	NSInteger length;
	NSMutableArray *tags;
}

@property (nonatomic, retain) NSString *mbid;
@property (nonatomic) NSInteger position;
@property (nonatomic, retain) NSString *title;
@property (nonatomic) NSInteger length;
@property (nonatomic, retain) NSMutableArray *tags;
@end
