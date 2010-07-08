//
//  TypeSelectionController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract:	Displays the search categories (e.g. Artist, Release) and let the user
//				choose the desired one

#import <UIKit/UIKit.h>
#import "Search.h";

@interface TypeSelectionController : UITableViewController {
	@private
	Search *search;
	SearchTypes currentType;
	
	bool detailSearch;
}
@property(nonatomic, retain) Search *search;
@end
