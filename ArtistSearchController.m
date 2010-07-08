//
//  ArtistSearchController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Displays the results of the Artist Search

#import "ArtistSearchController.h"
#import "ArtistController.h"
#import "Artist.h"


@implementation ArtistSearchController
@synthesize artists;
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO];	
	self.title = @"Artist Search";
	self.view.backgroundColor = [UIColor orangeColor];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [artists count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    Artist *artist = [artists objectAtIndex:indexPath.row];
	cell.textLabel.text	= artist.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// show detail page for selected artist
	Artist *artist = [artists objectAtIndex:indexPath.row];
	
	ArtistController *artistController = [[ArtistController alloc] init];
	
	// get details for release
	ServiceFacade *serviceFacade = [ServiceFacade alloc];
	serviceFacade.delegate = artistController;
	[serviceFacade getArtist:artist];
	
	[self.navigationController pushViewController:artistController	animated:YES];
	[artistController release];	
}

- (void) finishedRequest:(NSArray *) results {
	self.artists = [NSArray arrayWithArray:results];
	[self.tableView reloadData];
}

- (void)dealloc {
	artists = nil;
	[artists release];
    [super dealloc];
}

@end

