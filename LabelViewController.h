//
//  LabelViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for label entity

#import <UIKit/UIKit.h>
#import	"ServiceFacade.h"
#import "Label.h"

@interface LabelViewController : UITableViewController <DataCompleteDelegate> {
	Label *label;
	bool parsed;
	UIActivityIndicatorView *activityView;
}
@property(nonatomic, retain) Label *label;
@end
