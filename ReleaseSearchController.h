//
//  ReleaseSearchController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/7/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: Displays the results of the Release Search

#import <UIKit/UIKit.h>
#import	"ServiceFacade.h"

@interface ReleaseSearchController : UITableViewController <DataCompleteDelegate> {
	@private
	NSArray *releases;
	ServiceFacade *service;
}
@property (nonatomic, retain) NSArray *releases;
@end
