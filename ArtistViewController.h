//
//  ArtistViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/24/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for artist entity


#import <UIKit/UIKit.h>
#import "Artist.h"
#import "ServiceFacade.h"

@interface ArtistViewController : UITableViewController <DataCompleteDelegate> {
	Artist *artist;
}

@property (nonatomic, retain) Artist *artist;
@end
