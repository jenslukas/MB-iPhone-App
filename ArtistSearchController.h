//
//  ArtistSearchController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/23/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: Displays the results of the Artist Search

#import <UIKit/UIKit.h>
#import	"ServiceFacade.h"

@interface ArtistSearchController : UITableViewController <DataCompleteDelegate> {
@private
	NSArray *artists;
	ServiceFacade *service;
}
@property (nonatomic, retain) NSArray *artists;
@end
