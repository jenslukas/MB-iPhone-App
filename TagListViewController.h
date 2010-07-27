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
#import "TaggedEntity.h"

@interface TagListViewController : UITableViewController {
	id <TaggedEntity> entity;
}
@property(nonatomic, retain) id<TaggedEntity> entity;
-(void) addTag;
@end
