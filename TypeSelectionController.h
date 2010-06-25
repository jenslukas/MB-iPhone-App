//
//  TypeSelectionController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
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
