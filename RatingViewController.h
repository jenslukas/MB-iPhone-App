//
//  RatingViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 8/10/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Rating view to rate entity


#import <UIKit/UIKit.h>
#import "TaggedEntity.h"

@interface RatingViewController : UITableViewController {
	id <TaggedEntity> entity;
}
@property(nonatomic, retain) id <TaggedEntity> entity;
@end
