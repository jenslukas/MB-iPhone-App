//
//  ReleaseSearchController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Displays the results of the Release Search

#import <UIKit/UIKit.h>
#import	"ServiceFacade.h"

@interface ReleaseSearchController : UITableViewController <DataCompleteDelegate> {
	@private
	NSArray *releases;
	ServiceFacade *service;
}
@property (nonatomic, retain) NSArray *releases;
@end
