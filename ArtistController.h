//
//  ArtistController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for artist entity

#import <Foundation/Foundation.h>
#import "Artist.h"
#import "ServiceFacade.h"

@interface ArtistController : UIViewController <UITableViewDelegate, UITableViewDataSource,  DataCompleteDelegate> {
	Artist *artist;
	UILabel *artistNameLabel;
	UITableView *releasesTable;
}
@property(nonatomic, retain) Artist *artist;
@end
