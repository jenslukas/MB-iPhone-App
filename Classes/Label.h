//
//  Label.h
//  Musicbrainz
//
//  Created by Peter Katheter on 6/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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
