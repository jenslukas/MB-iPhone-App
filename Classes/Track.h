//
//  Track.h
//  Musicbrainz
//
//  Created by Peter Katheter on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Track : NSObject {
	NSString *mbid;
	NSInteger position;
	NSString *title;
	NSInteger length;
}

@property (nonatomic, retain) NSString *mbid;
@property (nonatomic) NSInteger position;
@property (nonatomic, retain) NSString *title;
@property (nonatomic) NSInteger length;
@end
