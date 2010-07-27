//
//  TaggedEntity.h
//  Musicbrainz
//
//  Created by Peter Katheter on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TaggedEntity
NSMutableArray *tags;

@property(nonatomic, retain) NSMutableArray *tags;
-(NSString *)getMBID;
@end
