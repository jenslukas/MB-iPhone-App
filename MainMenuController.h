//
//  MainMenuController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 5/27/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
//	Abstract: Main Menu view with basic search

#import <UIKit/UIKit.h>
#import "StringEditTableCell.h"
#import "Search.h"

@interface MainMenuController : UITableViewController {
	@private
	StringEditTableCell *editTableCell;
	Search *search;
}

@property(nonatomic, retain) StringEditTableCell *editTableCell;
@property(nonatomic, retain) Search *search;
@end
