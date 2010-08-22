//
//  AddTagViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 8/6/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: View to add tags

#import <UIKit/UIKit.h>
#import "StringEditTableCell.h"
#import "RateAndTaggableEntity.h"

@interface AddTagViewController : UITableViewController {
	StringEditTableCell *editTableCell;
	id <RateAndTaggableEntity> entity;
}
@property(nonatomic, retain) StringEditTableCell *editTableCell;
@property(nonatomic, retain) id<RateAndTaggableEntity> entity;
@end
