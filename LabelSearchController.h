//
//  LabelSearchController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Displays results of label search

#import <UIKit/UIKit.h>
#import "ServiceFacade.h"

@interface LabelSearchController : UITableViewController <DataCompleteDelegate> {
@private
	NSArray *labels;
	ServiceFacade *service;
}
@end

