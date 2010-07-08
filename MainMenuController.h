//
//  MainMenuController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Main Menu view with basic search

#import <UIKit/UIKit.h>
#import "StringEditTableCell.h"
#import "Search.h"

@interface MainMenuController : UITableViewController {
	@private
	StringEditTableCell *editTableCell;
	Search *search;
	UISwitch *advancedSearchSwitch;
}

@property(nonatomic, retain) StringEditTableCell *editTableCell;
@property(nonatomic, retain) Search *search;
@end
