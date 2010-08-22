//
//  TagListViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Show all tags of entity

#import <UIKit/UIKit.h>
#import "RateAndTaggableEntity.h"

@interface TagListViewController : UITableViewController {
	id <RateAndTaggableEntity> entity;
}
@property(nonatomic, retain) id<RateAndTaggableEntity> entity;
-(void) addTag;
@end
